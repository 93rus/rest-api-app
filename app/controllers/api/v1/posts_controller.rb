class Api::V1::PostsController < ApplicationController
    before_action :find_post, only: [:show, :update, :destroy]


    def index
        @posts = Post.all
        render json: @posts
    end

    def show
        render json: :post
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            render json: @post
        else
            render json: { error: 'Невозможно создать публикацию' }, status: 400
        end
    end

    def update
        if @post
            @post.update(post_params)
            render json: { message: 'Публикация обновлена' }, status: 200
        else
            render json: { error: 'Невозможно обновить публикацию' }, status: 400
        end
    end

    def destroy
        if @post
            @post.destroy
            render json: { message: 'Публикация удалена' }, status: 200
        else
            render json: { error: 'Невозможно удалить публикацию' }, status: 400
        end

    end




    private 
    
    def post_params
        params.require(:post).permit(:post, :likes, :user_id)
    end

    def find_post
        @post = Post.find(params[:id])
    end
end
