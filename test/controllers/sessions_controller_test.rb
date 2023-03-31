require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    OmniAuth.config.test_mode = true
  end

  test "should create session for existing user" do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: @user.provider,
      uid: @user.uid,
      info: { name: @user.name }
    })

    get "/auth/google_oauth2/callback"

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_not_nil json_response['auth_token']
  end

  test "should create session and new user for new user" do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: 'new_uid',
      info: { name: 'New User' }
    })

    assert_difference('User.count', 1) do
      get "/auth/google_oauth2/callback"
    end

    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_not_nil json_response['auth_token']
  end

  teardown do
    OmniAuth.config.test_mode = false
  end
end

