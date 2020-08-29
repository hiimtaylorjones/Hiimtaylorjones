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

	def destroy
		@page.destroy
		redirect_to admin_path
	end

	def show
		find_page_by_title(params[:title])
	end

	def edit
		find_page_by_title(params[:title])
	end

	private
		def find_page(id)
			@page = Page.find(id)
		end

		def find_page_by_title(title)
			query = Page.friendly.where(title: title)
			if query.exists?
				@page = query.first 
			else
				redirect_to root_path, notice: "Page not found"
			end
		end

		def page_params
			params.require(:page).permit(:title, :content)
		end
end
