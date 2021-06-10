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
		find_page(params[:title])
	end

	def edit
		find_page(params[:title])
	end

	private

		def find_page(url_arg)
			slug_search = Page.where(slug: url_arg.downcase)
			title_search = Page.friendly.where(title: url_arg)
			query = slug_search.or(title_search)
			
			if query.present?
				@page = query.first
			else
				redirect_to root_path, notice: "Page not found"
			end
		end

		def page_params
			params.require(:page).permit(:title, :content, :placement, :published)
		end
end
