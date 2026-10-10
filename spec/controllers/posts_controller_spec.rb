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

	describe "Assigning a post to a collection" do

		it "persists collection_id through post_params" do
			admin = FactoryBot.create(:admin)
			collection = FactoryBot.create(:collection)
			sign_in admin

			subject_post = FactoryBot.create(:post)
			patch :update, params: { id: subject_post.id, post: { collection_id: collection.id } }

			expect(subject_post.reload.collection).to eq(collection)
		end

		it "can clear a post's collection" do
			admin = FactoryBot.create(:admin)
			collection = FactoryBot.create(:collection)
			sign_in admin

			subject_post = FactoryBot.create(:post, collection: collection)
			patch :update, params: { id: subject_post.id, post: { collection_id: "" } }

			expect(subject_post.reload.collection).to be_nil
		end
	end

	describe "Collection in the post templates" do
		render_views

		it "offers a collection select on the post form, drafts included" do
			sign_in FactoryBot.create(:admin)
			draft_collection = FactoryBot.create(:collection, :unpublished, title: "Draft Series")

			get :new

			expect(response.body).to include("post[collection_id]")
			expect(response.body).to include("Draft Series")
		end

		it "links back to the collection from a post that has one" do
			collection = FactoryBot.create(:collection, title: "Learning Rust")
			subject_post = FactoryBot.create(:post, collection: collection)

			get :show, params: { id: subject_post.id }

			expect(response.body).to include("Part of")
			expect(response.body).to include(collection_path(collection))
		end

		it "omits the collection line for a standalone post" do
			subject_post = FactoryBot.create(:post, collection: nil)

			get :show, params: { id: subject_post.id }

			expect(response.body).not_to include("Part of")
		end
	end
end
