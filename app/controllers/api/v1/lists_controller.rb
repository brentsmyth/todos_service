module Api
  module V1
    class ListsController < BaseController
      before_action :set_user, only: [:index, :create]
      before_action :set_list, only: [:update, :destroy]

      # GET /users/:user_id/lists
      def index
        @lists = @user.lists
        render json: @lists
      end

      # POST /users/:user_id/lists
      def create
        @list = List.new(list_params)

        if @list.save
          UserList.create(user: @user, list: @list)
          render json: @list, status: :created
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /lists/:id
      def update
        if @list.update(list_params)
          render json: @list
        else
          render json: @list.errors, status: :unprocessable_entity
        end
      end

      # DELETE /lists/:id
      def destroy
        @list.destroy
        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_list
        @list = List.find(params[:id])
      end

      def list_params
        params.require(:list).permit(:name)
      end
    end
  end
end

