require "test_helper"

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = Item.new(name: "Example item", complete: false, list: lists(:one))
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "should not save item without name" do
    item = Item.new(complete: false, list: lists(:one))
    assert_not item.save, "Saved the item without a name"
  end

  test "should save item with a name and list" do
    item = Item.new(name: "Example item", complete: false, list: lists(:one))
    assert item.save, "Failed to save the item with a name and list"
  end

  test "should not save item without list" do
    item = Item.new(name: "Example item", complete: false)
    assert_not item.save, "Saved the item without a list"
  end

  test "should belong to list" do
    item = items(:one)
    assert_respond_to item, :list, "Item model does not have a belongs_to association with list"
  end
end

