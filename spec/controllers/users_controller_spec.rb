require 'spec_helper'

describe UsersController do
	describe "GET #new"
		it "assigns a new User to @user" do 
			user = FactoryGirl.create(:user)
		end
		it "renders the :new template" do
			get :new
			response.should render_template :new
		end
	describe "POST #create"
		context "with valid attributes" do
			it "saves the new user in the database" do
				expect {
					user :create, user: FactoryGirl.attributes_for(:user)
				}.to change(Userm :count).by(1)
			end
			it "redirects to homepage" do
				response.should render_template :root
			end
		end
		context "with invalid attributes" do
		end
			it "does not save the new user in the database"
			it "re-renders the :new template"
		end
	end
end
