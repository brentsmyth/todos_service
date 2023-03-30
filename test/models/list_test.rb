require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "should not save list without name" do
    list = List.new
    assert_not list.save, "Saved the list without a name"
  end

  test "should save list with a name" do
    list = List.new(name: "Example list")
    assert list.save, "Failed to save the list with a name"
  end

  test "should have many items" do
    list = lists(:one)
    assert_respond_to list, :items, "List model does not have a has_many association with items"
  end
end

