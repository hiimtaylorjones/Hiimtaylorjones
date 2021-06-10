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

  def update
    if Page.exists?(params[:id])
      page = Page.find(params[:id])
      page.update(page_params)
      render json: { status: 200, page: page, message: "Page sucessfully updated!" }
    else
      render json: { status: 404, page: nil, message: "Page not found!" }
    end
  end

private

  def page_params
    params.require(:page).permit(:title, :content, :published, :placement)
  end

end
