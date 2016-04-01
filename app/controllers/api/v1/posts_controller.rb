# frozen_string_literal: true
class Api::V1::PostsController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :new, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :success
    else
      render json: nil, status: :failure
    end
  end

  def show
    if @post.published == true
      render json: @post, status: :ok
      # @comment = Comment.new
    else
      render json: nil, status: :failure
    end
  end

  def destroy
    if @post.destroy
      render json: nil, status: :success
    else
      render json: nil, status: :failure
    end
  end

  def index
    @posts = Post.where(published: true)
    @posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    render json: @posts
  end

  def edit
    @post = Post.find(params[:id])
    render json: @post
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :success
    else
      render json: { message: 'Hello' }, status: :failure
    end
  end

  def comment_admin
    @post = Post.find(params[:post_id])
    render json: @post
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :tagline, :published, :body, :tag_list)
  end
end
