class ApplicationController < ActionController::Base
  def generate_csrf_token
    session[:csrf_token] = SecureRandom.hex(32)
  end
end
