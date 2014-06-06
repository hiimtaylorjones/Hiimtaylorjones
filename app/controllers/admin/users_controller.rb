class Admin::UsersController < ApplicationController
	def new
  		@user = User.new
	end

	def create
  		@user = User.new(user_params)
  		respond_to do |format|
	  		if @user.save
	    		format.html { redirect_to admin_users_url, 
		  				notice: 'user was successfully created.' }
		  			format.json {render json: @user, status: created,
		  				location: [:admin, @user]}
	  		else
	    		format.html { render action: "new" }
		  			format.json { render json: @user.errors, 
		  				status: :unprocessable_entity }
	  		end
	  	end
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user 
		else
			render 'edit'
		end
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end
