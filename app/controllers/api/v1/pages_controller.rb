# frozen_string_literal: true
class Api::V1::PagesController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :new, :edit, :update, :destroy]
  before_action :find_page, only: [:show, :edit, :destroy, :update]

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      render json: @page, status: :success
    else
      render json: nil, status: :failure
    end
  end

  def destroy
    if @page.destroy
      render json: nil, status: :success
    else
      render json: nil, status: :failure
    end
  end

  def show
  end

  def edit
  end

  def update
    if @page.update(page_params)
      render json: @page, status: :success
    else
      render json: @page, status: :failure
    end
  end

  private

  def find_page
    @page = Page.find(params[:id])
    render json: @page
  end

  def page_params
    params.require(:page).permit(:title, :content)
  end
end
