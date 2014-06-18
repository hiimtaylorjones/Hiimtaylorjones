class BasicPageController < ApplicationController
  def index
  end

  def blog
  end

  def resume
  end

  def about
  end

  def signup
  	@user = User.new(user_params)
  	respond_to do |format|
	  	if @user.save
	    	format.html { redirect_to users_url, notice: 'user was successfully created.' }
		  	format.json {render json: @user, status: created, location: [:user, @user]}
	  	else
	    	format.html { render action: "new" }
		  	format.json { render json: @user.errors, status: :unprocessable_entity }
	  	end
	end
  end

  private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
