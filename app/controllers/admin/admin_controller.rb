class AdminController < ApplicationController
	def new
  		@admin = Admin.new
	end

	def create
  		@admin = Admin.new(admin_params)
  		respond_to do |format|
	  		if @admin.save
	    		format.html { redirect_to admin_admins_url, 
		  				notice: 'admin was successfully created.' }
		  			format.json {render json: @admin, status: created,
		  				location: [:admin, @admin]}
	  		else
	    		format.html { render action: "new" }
		  			format.json { render json: @admin.errors, 
		  				status: :unprocessable_entity }
	  		end
	  	end
	end

	def show
		@admin = Admin.find(params[:id])
	end

	def destroy
		@admin = Admin.find(params[:id])
		@admin.destroy
		redirect_to admins_path
	end

	def index
		@admins = Admin.all
	end

	def edit
		@admin = Admin.find(params[:id])
	end

	def update
		@admin = Admin.find(params[:id])
		if @admin.update(admin_params)
			redirect_to @admin 
		else
			render 'edit'
		end
	end

	private
		def admin_params
			params.require(:admin).permit(:email, :password, :password_confirmation)
		end
end
