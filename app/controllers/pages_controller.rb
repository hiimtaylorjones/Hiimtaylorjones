class PagesController < ApplicationController
	def new
		@page = Page.new
	end

	def create
  		@page = Page.new(page_params)
  		respond_to do |format| 
	 		if @page.save
	  			format.html { 
	  				redirect_to admin_url, 
	  				notice: 'Page was successfully created.' 
	  			}
	  			format.json {
	  				render json: @page, 
	  				status: created,
	  				location: @page
	  			}
	  		else
	  			format.html { render action: "new" }
	  			format.json { 
	  				render json: @page.errors, 
	  				status: :unprocessable_entity 
	  			}
	  		end
	  	end
	end

	def show
		@page = Page.find(params[:id])
	end

	def destroy
		@page = Page.find(params[:id])
		@page.destroy
		authorize! :manage, @page
		redirect_to admin_path
	end

	def edit
		@page = Page.find(params[:id])
		authorize! :manage, @page
	end

	def update
		@page = Page.find(params[:id])
		if @page.update(page_params)
			redirect_to @page 
		else
			render 'edit'
		end
	end

	private
		def page_params
			params.require(:page).permit(:title, :content)
		end
end
