 class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.approved = false

    if comment.save
      redirect_to post,
        notice: "We've recieved your comment. If it meets our guidlines, then you'll see it very soon!"
    else
      redirect_to post,
        alert: comment.errors.full_messages
    end
  end

  # Allowing me, as the admin to respond to a comment.
  # It allows for better discourse, while ensuring that I address
  # certain things about my writing.

  def respond
  end

  def approve
    comment = Comment.find(params[:comment_id])
    comment.approved = true
    if comment.save
      redirect_to post_comment_admin_path(:post_id => params[:post_id]), notice: "Comment has been approved."
    else
      redirect_to post_comment_admin_path(:post_id => params[:post_id]), alert: "Comment was unable to be approved."
    end
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
    redirect_to post_comment_admin_path(post_id: post.id)
  end

  private
    def comment_params
      params.permit(:name, :email, :message)
    end
end
