require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should have many user_lists" do
    assert_respond_to @user, :user_lists
    assert_equal @user.user_lists.size, 0
  end

  test "should have many lists through user_lists" do
    assert_respond_to @user, :lists
    assert_equal @user.lists.size, 0
  end
end

