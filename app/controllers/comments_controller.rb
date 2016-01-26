 class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)

    if comment.save
      redirect_to post,
        notice: "We've recieved your comment. If it meets our guidlines, then you'll see it very soon!"
    else
      redirect_to post,
        alert: "We were unable to create your comment. Please check your fields and try again!"
    end
  end

  def edit
    post = Post.find(params[:id])
    @comment = post.comments.find(comment_params)
  end

  def update
    post = Post.find(params[:id])
    if post.comments.update(comment_params)
      redirect_to post
    else
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = post.comments.find(params[:id])
    @comment.destroy
    redirect_to post
  end

  private
    def comment_params
      params.permit(:name, :email, :message)
    end
end
