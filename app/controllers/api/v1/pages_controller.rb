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
    page = find_page_by_title(page_params[:title])
    if page.update(page_params)
      render json: { status: :ok, page: page, message: "Page sucessfully updated!" }
    else
      render json: { status: 422, page: page, message: "Could not update page" }
    end
  end

private

  def find_page_by_title(title)
    query = Page.where(title: title.capitalize)
    if query.exists?
      return page = query.first 
    else
      render json: { status: 404, page: nil, message: "Page not found" }
    end
  end

  def page_params
    params.require(:page).permit(:title, :content, :published)
  end

end
