require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
	describe "Post Index" do 
	    describe "GET #index" do
	      it "responds successfully with an HTTP 200 status code" do
	        get :index
	        expect(response).to be_success
	        expect(response).to have_http_status(200)
	      end

	      it "renders the index template" do
	        get :index
	        expect(response).to render_template(:index)
	      end
	    end
	end

	describe "Show Post" do 

		before(:each) do
			@post = FactoryGirl.create(:post)
		end

		describe "Get Post to Show" do

			it "responds successfully with an HTTP 200 status code" do
				get :show, id: @post
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end

			it "renders the show template" do
				get :show, id: @post
				expect(response).to render_template(:show)
			end 
		end
	end

	describe "Admin Interacitons" do

		#User needs to log in

		before(:each) do
			@current = login_user
			@post = FactoryGirl.create(:post)
		end

		describe "Your dumb Admin can't spell. (Edit Post)" do 

			it "responds successfully with an HTTP 200 status code" do
				get :edit, id: @post
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end

			it "renders the edit template" do
				get :edit, id: @post
				expect(response).to render_template(:edit)
			end

			it "should allow user to sign out, once finished." do
				sign_out @current
				expect(subject.current_user).to be_nil
			end
		end

		describe "That silly Admin said something stupid. (Delete Post)" do 
			it "Their post should successfuly delete" do 
				delete :destroy, id: @post
				expect(response).to render_template(:admin)
			end
		end
	end


	# describe "Delete Post"

	# 	before(:each) do
	# 		login_user
	# 		@post = FactoryGirl.create(:post)
	# 	end

	# 	describe "Get Post to Delete" do 
	# 		it "should successfuly delete" do 
	# 			expect(delete :destroy, :id => @post).should change(Post, :count)
	# 		end
	# 	end

end