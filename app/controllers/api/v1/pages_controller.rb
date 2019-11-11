class Api::V1::PagesController < ApplicationController

  def index
    pages = if params[:per_page]
      Page.last(params[:per_page])
    else
      Page.last(10)
    end
    pages_json = {
      data: pages,
      pagination: {
        page: 1,
        per_page: 10 
      }
    }
    render json: pages_json, status: :ok
  end

private 

  def page_params
    params.require(:page).permit(:title, :body, :published)
  end

end
