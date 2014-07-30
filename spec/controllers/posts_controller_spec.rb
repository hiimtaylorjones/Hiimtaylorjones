require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
	describe "Post Index"
	    describe "GET #index" do
	      it "responds successfully with an HTTP 200 status code" do
	        get :index
	        expect(response).to be_success
	        expect(response).to have_http_status(200)
	      end

	      it "renders the index template" do
	        get :index
	        expect(response).to render_template("index")
	      end
	    end
	describe "Show Post"
		describe "Get Post" do
			it "responds successfully with an HTTP 200 status code" do
				get :show, id: 1
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end
		end

	describe "Edit Post"

	describe "Delete Post"
end