class Api::V1::PostsController < ApplicationController

  def index
    posts = if params[:per_page]
      Post.order('created_at DESC').limit(params[:per_page])
    else
      Post.order('created_at DESC').limit(10)
    end
    json_payload = json_outline(posts)
    render json: json_payload, status: :ok
  end

  def feedback
    post = Post.find(params[:post_id])
    comments = post.comments
    json_payload = json_outline(comments)
    render json: json_payload, status: :ok
  end

private
  
  def json_outline(resource)
    json = {
      data: resource,
      pagination: {
        page: 1,
        per_page: 10 
      }
    }
  end

end
