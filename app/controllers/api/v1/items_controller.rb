module Api
  module V1
    class ItemsController < BaseController
      before_action :set_list, only: [:index, :create]
      before_action :set_item, only: [:update, :destroy]

      # GET /api/v1/lists/:list_id/items
      def index
        render json: @list.items
      end

      # POST /api/v1/lists/:list_id/items
      def create
        @item = @list.items.new(item_params)

        if @item.save
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/items/:id
      def update
        if @item.update(item_params)
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # DELETE /items/:id
      def destroy
        @item.destroy
        head :no_content
      end

      private

      def set_list
        @list = @current_user.lists.find(params[:list_id])
      end

      def set_item
        @item = Item.joins(list: :user_lists).find_by(id: params[:id], user_lists: { user_id: @current_user.id })
      end

      def item_params
        params.require(:item).permit(:name, :complete)
      end
    end
  end
end

