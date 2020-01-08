require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

	describe "Post Index" do
	  describe "GET #index" do
	    it "responds successfully with an HTTP 200 status code" do
	      get :index
	      expect(response).to be_successful
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
			@post = FactoryBot.create(:post)
		end

		describe "Get Post to Show" do

			it "responds successfully with an HTTP 200 status code" do
				get :show, params: { id: @post.id }
				expect(response).to be_successful
				expect(response).to have_http_status(200)
			end

			it "renders the show template" do
				get :show, params: { id: @post.id }
				expect(response).to render_template(:show)
			end
		end
	end

	describe "Admin Interacitons" do

		#User needs to log in

		before(:each) do
			@admin = FactoryBot.create(:admin)
			sign_in @admin
			@post = FactoryBot.create(:post)
		end

		describe "Your dumb Admin can't spell. (Edit Post)" do

			it "responds successfully with an HTTP 200 status code" do
				get :edit, params: { id: @post.id } 
				expect(response).to be_successful
				expect(response).to have_http_status(200)
			end

			it "renders the edit template" do
				get :edit, params: { id: @post.id }
				expect(response).to render_template(:edit)
			end
		end
	end
end
