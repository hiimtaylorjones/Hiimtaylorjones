class PagesController < ApplicationController

	before_action :authenticate_admin!, only: [:create, :new, :edit, :update, :destroy]

	def new
		@page = Page.new
	end

	def create
  		@page = Page.new(page_params)
  		if @page.save
	  		redirect_to admin_url, notice: 'Page was successfully created.'
	  	else
	  		render action: "new"
	  	end
	end

	def show
		@page = Page.find(params[:id])
	end

	def destroy
		@page = Page.find(params[:id])
		@page.destroy
		redirect_to admin_path
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
		if @page.update(page_params)
			redirect_to admin_path
		else
			render 'edit'
		end
	end

	private
		def page_params
			params.require(:page).permit(:title, :content)
		end
end
