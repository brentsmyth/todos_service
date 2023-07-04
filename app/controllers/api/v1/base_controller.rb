module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :authenticate_user!

      private

      def authenticate_user!
        token = request.headers['Authorization']&.split(' ')&.last
        begin
          if token
            decoded_token = JWT.decode(token, ENV["JWT_SECRET"], true, { algorithm: 'HS256' })[0]
            @current_user = User.find(decoded_token['user_id'])
          end

          head :unauthorized unless @current_user
        rescue JWT::ExpiredSignature
          head :forbidden
        end
      end
    end
  end
end
