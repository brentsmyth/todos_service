class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(auth_hash)

    if @user
      render json: { auth_token: @user.generate_jwt }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end

