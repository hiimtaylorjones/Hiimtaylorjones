class InquiriesController < ApplicationController
	
	load_and_authorize_resource
	skip_authorize_resource :only => :new

	def new
		@inquiry = Inquiry.new
		@page = Page.find(2)
	end

	def create
  		@inquiry = Inquiry.new(inquiry_params)
  		respond_to do |format| 
	 		if @inquiry.save
	  			format.html { 
	  				redirect_to root_url, 
	  				notice: 'Your work request has been successfully sent. We will contact you in the near future!' 
	  			}
	  			format.json {
	  				render json: @inquiry, 
	  				status: created,
	  				location: @inquiry
	  			}
	  		else
	  			format.html { render action: "new" }
	  			format.json { 
	  				render json: @inquiry.errors, 
	  				status: :unprocessable_entity 
	  			}
	  		end
	  	end
	end

	def show
		@inquiry = Inquiry.find(params[:id])
	end

	def destroy
		@inquiry = Inquiry.find(params[:id])
		@inquiry.destroy
		authorize! :manage, @inquiry
		redirect_to admin_path
	end

	def edit
		@inquiry = Inquiry.find(params[:id])
		authorize! :manage, @inquiry
	end

	def update
		@inquiry = Inquiry.find(params[:id])
		if @inquiry.update(inquiry_params)
			redirect_to @inquiry 
		else
			render 'edit'
		end
	end

	private
		def inquiry_params
			params.require(:inquiry).permit(:name, :company, :email, :phone, :job_description, :finish_date)
		end
end
