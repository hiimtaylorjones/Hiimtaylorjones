# frozen_string_literal: true
class Api::V1::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)
    @comment.approved = false

    if comment.save
      render json: @comment, status: :success
    else
      render json: nil, status: :failure
    end
  end

  # Allowing me, as the admin to respond to a comment.
  # It allows for better discourse, while ensuring that I address
  # certain things about my writing.

  def respond
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:comment_id])
    @resp = comment.response = Response.new(
      comment_id: params[:comment_id],
      message: params[:message]
    )
    if resp.save
      render json: @resp, status: :success
    else
      render json: nil, status: :failure
    end
  end

  def approve
    comment = Comment.find(params[:comment_id])
    comment.approved = true
    if comment.save
      render json: comment, status: :success
    else
      render json: comment, status: :failure
    end
  end

  def update
    post = Post.find(params[:id])
    @comment = post.comments.find(params[:comment_id])
    if @comment.update(comment_params)
      render json: @comment, status: :success
    else
      render json: @comment, status: :failure
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    if @comment.destroy
      render json: nil, status: :success
    else
      render json: nil, status: :failure
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :email, :message)
  end
end
