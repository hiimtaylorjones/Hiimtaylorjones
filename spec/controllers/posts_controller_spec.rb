require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

	describe "Post Index" do
		# No other spec renders posts/index, so render it for real here.
		render_views

		# Fifteen posts at ten per page makes two pages.
		before(:each) do
			FactoryBot.create_list(:post, 15)
		end

		describe "GET #index" do
			it "responds successfully with an HTTP 200 status code" do
				get :index
				expect(response).to have_http_status(200)
			end

			it "renders the index template" do
				get :index
				expect(response).to render_template(:index)
			end

			it "treats the page param as a number" do
				get :index, params: { page: "1" }
				expect(assigns(:page)).to eq(1)
			end

			it "is not on the last page while older posts remain" do
				get :index
				expect(assigns(:at_last_page)).to eq(false)
			end

			it "knows when it is on the last page" do
				get :index, params: { page: "2" }
				expect(assigns(:at_last_page)).to eq(true)
			end
		end

		describe "paging buttons" do
			def button(label)
				Nokogiri::HTML(response.body).css("a.button").find { |a| a.text == label }
			end

			it "offers only older posts on the first page" do
				get :index
				expect(button("Show Older")&.[]("href")).to eq(posts_path(page: 2))
				expect(button("Show Newer")).to be_nil
			end

			it "offers only newer posts on the last page" do
				get :index, params: { page: "2" }
				expect(button("Show Newer")&.[]("href")).to eq(posts_path(page: 1))
				expect(button("Show Older")).to be_nil
			end

			it "offers no paging when everything fits on one page" do
				Post.limit(5).destroy_all
				get :index
				expect(button("Show Older")).to be_nil
				expect(button("Show Newer")).to be_nil
			end
		end
	end

	describe "Admin Interactions" do

		before(:each) do
			@admin = FactoryBot.create(:admin)
			@post = FactoryBot.create(:post)
		end

		describe "Edit Post" do

			it "responds successfully with an HTTP 200 status code" do
				sign_in @admin
				get :edit, params: { id: @post.id }
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

	describe "Edit Post button" do
		render_views

		let(:live) { FactoryBot.create(:post) }

		it "sits in the post header for an admin" do
			sign_in FactoryBot.create(:admin)
			get :show, params: { id: live.id }
			header = Nokogiri::HTML(response.body).at_css(".post-header")
			expect(header.at_css("a[href='#{edit_post_path(live.friendly_id)}']")&.text).to eq("Edit Post")
		end

		it "is hidden from visitors" do
			get :show, params: { id: live.id }
			expect(response.body).not_to include("Edit Post")
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

		it "offers a collection select on the post form, inactive ones included" do
			sign_in FactoryBot.create(:admin)
			FactoryBot.create(:collection, :inactive, title: "Inactive Series")

			get :new

			expect(response.body).to include("post[collection_id]")
			expect(response.body).to include("Inactive Series")
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

		# An inactive collection's grouping does not apply, so a visitor must see
		# neither its title nor a link to it — the link would only bounce them.
		it "hides an inactive collection from a visitor entirely" do
			inactive = FactoryBot.create(:collection, :inactive, title: "Secret Series")
			subject_post = FactoryBot.create(:post, collection: inactive)

			get :show, params: { id: subject_post.id }

			expect(response).to have_http_status(200)
			expect(response.body).not_to include("Part of")
			expect(response.body).not_to include("Secret Series")
			expect(response.body).not_to include(collection_path(inactive))
		end

		it "shows an inactive collection to an admin, marked as such" do
			sign_in FactoryBot.create(:admin)
			inactive = FactoryBot.create(:collection, :inactive, title: "Secret Series")
			subject_post = FactoryBot.create(:post, collection: inactive)

			get :show, params: { id: subject_post.id }

			expect(response.body).to include("Secret Series")
			expect(response.body).to include("(inactive)")
		end
	end
end
