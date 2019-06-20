 class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.approved = false

    if post.commenting_enabled? == false
      redirect_path post,
        notice: "Commenting isn't enabled on this post yet. Check back later to see if we're looking for feedback on this post!"
    elsif comment.save
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
    build_comment_response_resources

    if resp.save
      redirect_to post_comment_admin_path,
        notice: 'Response created!'
    else
      redirect_to post_comment_admin_path,
        alert: 'Response could not be created.'
    end
  end

  def approve
    build_approved_comment

    post_id = params[:post_id]
    redirect_path = post_comment_admin_path(post_id: post_id)

    if comment.save
      redirect_to redirect_path, notice: "Comment has been approved."
    else
      redirect_to redirect_path, alert: "Comment was unable to be approved."
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

    def build_comment_response_resources
      comment_id = params[:comment_id]
      post = Post.find(params[:post_id])
      comment = post.comments.find(id)

      resp = comment.response = Response.new(
        comment_id: comment_id,
        message: params[:message]
      )
    end

    def build_approved_comment
      comment = Comment.find(params[:comment_id])
      comment.approved = true
    end
end
