class InquiriesController < ApplicationController

	def new
		@inquiry = Inquiry.new
		@page = Page.find(2)
	end

	def create
  		@inquiry = Inquiry.new(inquiry_params)
	 		if @inquiry.save
	  		redirect_to root_url, notice: 'Your work request has been successfully sent. We will contact you in the near future!'
	  	else
	  		render action: "new"
	  	end
	end

	def show
		@inquiry = Inquiry.find(params[:id])
	end

	def destroy
		@inquiry = Inquiry.find(params[:id])
		@inquiry.destroy
		redirect_to admin_path
	end

	def edit
		@inquiry = Inquiry.find(params[:id])
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
