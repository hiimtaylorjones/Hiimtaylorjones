 class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to @post
  end

  def edit
    @post = Post.find(params[:id])
    @comment = @post.comments.find(comment_params)
  end

  def update
    @post = Post.find(params[:id])
    if @post.comments.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
