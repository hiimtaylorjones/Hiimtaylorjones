require 'spec_helper'
require 'support/login_macros'

describe Admin::DashboardController do
	describe "user access" do
		describe "GET #index" do 
			it "returns http success" do 
				user = FactoryGirl.create(:user)
				session[:user_id] = user
				get 'index'
				response.should be_success
			end
		end
	end

	describe "non-user access" do 
		describe "GET #index" do 
			it "redirects to the login form" do
				get 'index'
				response.should redirect_to login_path
			end
		end
	end
end
