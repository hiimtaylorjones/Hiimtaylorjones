class PagesController < ApplicationController

	before_action :authenticate_admin!, only: [:create, :new, :edit, :update, :destroy]
	before_action :find_page, only: [:show, :edit, :destroy, :update]

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

	def destroy
		@page.destroy
		redirect_to admin_path
	end

	def show
	end

	def edit
	end

	def update
		if @page.update(page_params)
			redirect_to admin_path
		else
			render 'edit'
		end
	end

	private
		def find_page
			@page = Page.find(params[:id])
		end

		def page_params
			params.require(:page).permit(:title, :content)
		end
end
