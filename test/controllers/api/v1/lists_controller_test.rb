require "test_helper"

module API
  module V1
    class ListsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @list = lists(:one)
        @user = users(:one)
        @token = @user.generate_jwt
      end

      test "should get index" do
        get api_v1_lists_url, headers: { "Authorization": "Bearer #{@token}" }, as: :json
        assert_response :success
      end

      test "should create list" do
        assert_difference('List.count') do
          post api_v1_lists_url, params: { list: { name: 'New list' } }, headers: { "Authorization": "Bearer #{@token}" }, as: :json
        end

        assert_response :created
      end

      test "should not create list without name" do
        assert_no_difference('List.count') do
          post api_v1_lists_url, params: { list: { name: '' } }, headers: { "Authorization": "Bearer #{@token}" }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test "should update list" do
        patch api_v1_list_url(@list), params: { list: { name: 'Updated list name' } }, headers: { "Authorization": "Bearer #{@token}" }, as: :json
        assert_response :success
      end

      test "should not update list with empty name" do
        patch api_v1_list_url(@list), params: { list: { name: '' } }, headers: { "Authorization": "Bearer #{@token}" }, as: :json
        assert_response :unprocessable_entity
      end

      test "should destroy list" do
        assert_difference('List.count', -1) do
          delete api_v1_list_url(@list), headers: { "Authorization": "Bearer #{@token}" }, as: :json
        end

        assert_response :no_content
      end
    end
  end
end

