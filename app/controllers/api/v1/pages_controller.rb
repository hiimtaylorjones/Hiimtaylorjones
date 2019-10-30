class Api::V1::PagesController < ApplicationController

  def index
    @pages = Page.all
    render json: @pages, status: :ok
  end

private 

  def page_params
    params.require(:page).permit(:title, :body, :published)
  end

end
