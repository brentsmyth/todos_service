require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    OmniAuth.config.test_mode = true
  end

  test "should generate csrf token and set it in session" do
    get "/auth/google_oauth2_redirect"
    assert_response :redirect
    assert_not_nil session[:csrf_token]
  end

  test "should return 403 forbidden for invalid csrf token" do
    get "/auth/google_oauth2_redirect"
    get "/auth/google_oauth2/callback", params: { state: "invalid_csrf_token" }
    assert_response :forbidden
  end

  test "should create auth token for existing user" do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: @user.provider,
      uid: @user.uid,
      info: { name: @user.name }
    })

    get "/auth/google_oauth2_redirect"
    state = session[:csrf_token]

    get "/auth/google_oauth2/callback", params: { state: state }

    assert_response :success
    assert_match /var authToken/, @response.body
  end

  test "should create auth token and new user for new user" do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: 'new_uid',
      info: { name: 'New User' }
    })

    get "/auth/google_oauth2_redirect"
    state = session[:csrf_token]

    assert_difference('User.count', 1) do
      get "/auth/google_oauth2/callback", params: { state: state }
    end

    assert_response :success
    assert_match /var authToken/, @response.body
  end

  teardown do
    OmniAuth.config.test_mode = false
  end
end
