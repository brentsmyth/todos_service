module Api
  module V1
    class ListsController < BaseController
      before_action :set_list, only: [:update, :destroy]

      # GET /api/v1/lists
      def index
        render json: @current_user.lists
      end

      # POST /api/v1/lists
      def create
        @list = List.new(list_params)

        if @list.save
          UserList.create(user: @current_user, list: @list)
          render json: @list, status: :created
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/lists/:id
      def update
        if @list.update(list_params)
          render json: @list
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/lists/:id
      def destroy
        @list.destroy
        head :no_content
      end

      private

      def set_list
        @list = @current_user.lists.find(params[:id])
      end

      def list_params
        params.require(:list).permit(:name)
      end
    end
  end
end

