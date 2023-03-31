require "test_helper"

module Api
  module V1
    class BaseControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @jwt = @user.generate_jwt
      end

      test "should return unauthorized without valid JWT" do
        get api_v1_lists_url, headers: { 'Authorization' => '' }
        assert_response :unauthorized
      end

      test "should return success with valid JWT" do
        get api_v1_lists_url, headers: { 'Authorization' => "Bearer #{@jwt}" }
        assert_response :success
      end
    end
  end
end

