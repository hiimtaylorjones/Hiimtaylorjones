require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

	describe "Post Index" do
		before(:each) do
			FactoryBot.create_list(:post, 10)
		end

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

		before(:each) do
			@admin = FactoryBot.create(:admin)
			@post = FactoryBot.create(:post)
		end

		describe "Your dumb Admin can't spell. (Edit Post)" do

			it "responds successfully with an HTTP 200 status code" do
				sign_in @admin
				get :edit, params: { id: @post.id } 
				expect(response).to be_successful
				expect(response).to have_http_status(200)
			end

			it "renders the edit template" do
				sign_in @admin
				get :edit, params: { id: @post.id }
				expect(response).to render_template(:edit)
			end
		end
	end

	describe "Unpublished posts" do

		it "redirects instead of rendering when a post is unpublished" do
			draft = FactoryBot.create(:post, :unpublished)
			get :show, params: { id: draft.id }
			expect(response).to redirect_to(posts_path)
		end

		# `posts.published` has no DB default, so legacy rows are NULL rather than false.
		it "redirects when published is nil rather than false" do
			draft = FactoryBot.create(:post, :never_published)
			get :show, params: { id: draft.id }
			expect(response).to redirect_to(posts_path)
		end

		it "still renders a published post" do
			live = FactoryBot.create(:post)
			get :show, params: { id: live.id }
			expect(response).to have_http_status(200)
		end
	end

	describe "Posts with a banner image" do
		render_views

		it "renders the show page without raising" do
			bannered = FactoryBot.create(:post, :with_banner_image)
			get :show, params: { id: bannered.id }
			expect(response).to have_http_status(200)
		end
	end
end
