module Api
  module V1
    class ItemsController < BaseController
      before_action :set_list, only: [:index, :create]
      before_action :set_item, only: [:update, :destroy]

      # GET /lists/:list_id/items
      def index
        @items = @list.items
        render json: @items
      end

      # POST /lists/:list_id/items
      def create
        @item = @list.items.new(item_params)

        if @item.save
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /items/:id
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
        @list = List.find(params[:list_id])
      end

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:name, :complete)
      end
    end
  end
end

