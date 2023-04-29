class AuthenticationController < ApplicationController
  def google_oauth2_redirect
    generate_csrf_token
    redirect_to "/auth/google_oauth2?state=#{session[:csrf_token]}"
  end

  def google_oauth2_callback
    if session[:csrf_token] != params['state']
      render status: :forbidden, plain: "Invalid CSRF token"
    else
      user = User.from_omniauth(auth_hash)
      @auth_token = user.generate_jwt
      render inline: <<-HTML
        <!DOCTYPE html>
        <html>
          <body>
            <script>
              var authToken = "#{@auth_token}";
            </script>
          </body>
        </html>
      HTML
    end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

