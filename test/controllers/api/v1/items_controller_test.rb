require 'test_helper'

module API
  module V1
    class ItemsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @item = items(:one)
        @list = lists(:one)
      end

      test 'should get index' do
        get api_v1_list_items_url(@list)
        assert_response :success
      end

      test 'should create item' do
        assert_difference('Item.count') do
          post api_v1_list_items_url(@list), params: { item: { name: 'New item', complete: false } }
        end

        assert_response :created
      end

      test 'should not create item with empty name' do
        assert_no_difference('Item.count') do
          post api_v1_list_items_url(@list), params: { item: { name: '', complete: false } }
        end

        assert_response :unprocessable_entity
      end

      test 'should update item' do
        patch api_v1_item_url(@item), params: { item: { name: 'Updated item', complete: true } }
        assert_response :success
      end

      test 'should not update item with empty name' do
        patch api_v1_item_url(@item), params: { item: { name: '', complete: true } }
        assert_response :unprocessable_entity
      end

      test 'should destroy item' do
        assert_difference('Item.count', -1) do
          delete api_v1_item_url(@item)
        end

        assert_response :no_content
      end
    end
  end
end

