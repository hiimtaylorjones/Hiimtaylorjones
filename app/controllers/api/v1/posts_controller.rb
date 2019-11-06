class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

private 

  def page_params
    params.require(:post).permit(:title, :body, :published)
  end

end
