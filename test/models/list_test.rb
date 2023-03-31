require "test_helper"

class ListTest < ActiveSupport::TestCase
  def setup
    @list = List.new(name: "Example list")
  end

  test "should be valid" do
    assert @list.valid?
  end

  test "should not save list without name" do
    list = List.new
    assert_not list.save, "Saved the list without a name"
  end

  test "should save list with a name" do
    assert @list.save, "Failed to save the list with a name"
  end

  test "should have many user_lists" do
    assert_respond_to @list, :user_lists
    assert_equal @list.user_lists.size, 0
  end

  test "should have many users through user_lists" do
    assert_respond_to @list, :users
    assert_equal @list.users.size, 0
  end

  test "should have many items" do
    list = lists(:one)
    assert_respond_to list, :items, "List model does not have a has_many association with items"
  end
end

