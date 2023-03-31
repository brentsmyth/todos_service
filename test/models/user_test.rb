require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "provider should be present" do
    @user.provider = ""
    assert_not @user.valid?
  end

  test "uid should be present" do
    @user.uid = ""
    assert_not @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "uid and provider combination should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should create user from omniauth" do
    auth = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '1234567890',
      info: { name: 'John Doe' }
    })

    user = User.from_omniauth(auth)

    assert user.valid?
    assert_equal auth.provider, user.provider
    assert_equal auth.uid, user.uid
    assert_equal auth.info.name, user.name
  end

  test "should update existing user from omniauth" do
    auth = OmniAuth::AuthHash.new({
      provider: @user.provider,
      uid: @user.uid,
      info: { name: 'Updated Name' }
    })

    updated_user = User.from_omniauth(auth)

    assert_equal @user.id, updated_user.id
    assert_equal auth.info.name, updated_user.name
  end

  test "should generate valid jwt" do
    jwt = @user.generate_jwt
    decoded_jwt = JWT.decode(jwt, ENV['JWT_SECRET'], true, { algorithm: 'HS256' })

    assert_equal @user.id, decoded_jwt[0]['user_id']
  end

  test "should have many user_lists" do
    assert_respond_to @user, :user_lists
    assert_equal @user.user_lists.size, 2
  end

  test "should have many lists through user_lists" do
    assert_respond_to @user, :lists
    assert_equal @user.lists.size, 2
  end
end

