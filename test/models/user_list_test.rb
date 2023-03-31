require "test_helper"

class UserListTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @list = lists(:one)
    @user_list = UserList.new(user: @user, list: @list)
  end

  test "should be valid" do
    assert @user_list.valid?
  end

  test "should belong to user" do
    assert_respond_to @user_list, :user
    assert_equal @user_list.user, @user
  end

  test "should belong to list" do
    assert_respond_to @user_list, :list
    assert_equal @user_list.list, @list
  end
end

