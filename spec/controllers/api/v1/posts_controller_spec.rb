require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe 'Post Index' do

    before(:each) do
      @posts = FactoryGirl.create_list(:post, 5)
    end

	  describe 'GET #index' do
	    it 'responds successfully with an HTTP 200 status code' do
	      get :index
	      resp = JSON.parse(response.body)
        expect(resp['posts'].length).to eql @posts.count
	    end
	  end
	end

	describe 'Show Post' do

		before(:each) do
			@post = FactoryGirl.create(:post)
		end

		describe 'Get Post to Show' do
			it 'responds successfully with an HTTP 200 status code' do
				get :show, id: @post
        resp = JSON.parse(response.body)
        expect(resp['post']['title']).to eql @post.title
			end
		end
	end

	describe 'Admin Interacitons' do

		#User needs to log in

		before(:each) do
			@admin = FactoryGirl.create(:admin)
			sign_in @admin
			@post = FactoryGirl.create(:post)
		end

		describe 'Editing a post' do

			it 'responds successfully with an HTTP 200 status code' do
				get :edit, id: @post
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end
		end
	end
end
