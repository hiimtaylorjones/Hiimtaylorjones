class Api::V1::PostsController < ApplicationController

  def index
    @posts = if params[:per_page]
      Post.order('created_at DESC').limit(params[:per_page])
    else
      Post.order('created_at DESC').limit(10)
    end
    json_payload = json_outline(@posts)
    render json: json_payload, status: :ok
  end

private
  
def json_outline(posts)
    json = {
      data: posts,
      pagination: {
        page: 1,
        per_page: 10 
      }
    }
  end

end
