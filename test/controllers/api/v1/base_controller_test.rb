require "test_helper"
require "mocha/minitest"

module Api
  module V1
    class BaseControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @jwt = @user.generate_jwt
        @expired_jwt = "expired_jwt"
      end

      test "should return unauthorized without valid JWT" do
        get api_v1_lists_url, headers: { 'Authorization' => '' }
        assert_response :unauthorized
      end

      test "should return success with valid JWT" do
        get api_v1_lists_url, headers: { 'Authorization' => "Bearer #{@jwt}" }
        assert_response :success
      end

      test "should return forbidden with expired JWT" do
        JWT.stubs(:decode).with(@expired_jwt, ENV["JWT_SECRET"], true, { algorithm: 'HS256' }).raises(JWT::ExpiredSignature)
        get api_v1_lists_url, headers: { 'Authorization' => "Bearer #{@expired_jwt}" }
        assert_response :forbidden
        JWT.unstub(:decode)
      end
    end
  end
end
