class InquiriesController < ApplicationController

	before_action :authenticate_admin!, only: [:update, :edit, :destroy]
	before_action :find_inquiry, only: [:show, :edit, :update, :destroy]

	def new
		@inquiry = Inquiry.new
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
	end

	def destroy
		@inquiry.destroy
		redirect_to admin_path
	end

	def edit
	end

	def update
		if @inquiry.update(inquiry_params)
			redirect_to @inquiry
		else
			render 'edit'
		end
	end

	private
		def find_inquiry
			@inquiry = Inquiry.find(params[:id])
		end

		def inquiry_params
			params.require(:inquiry).permit(:name, :company, :email, :phone, :job_description, :finish_date)
		end
end
