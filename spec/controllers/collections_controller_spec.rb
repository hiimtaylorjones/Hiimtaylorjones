require 'rails_helper'

RSpec.describe CollectionsController, :type => :controller do

	# These templates are new; render them for real so ERB errors surface here.
	render_views

	describe "Collection Index" do
		it "responds successfully and renders the index template" do
			FactoryBot.create(:collection, :with_posts)
			get :index
			expect(response).to have_http_status(200)
			expect(response).to render_template(:index)
		end

		it "omits collections with nothing published in them" do
			empty = FactoryBot.create(:collection)
			get :index
			expect(assigns(:collections)).not_to include(empty)
		end
	end

	describe "Show Collection" do
		it "responds successfully and renders the show template" do
			collection = FactoryBot.create(:collection, :with_posts)
			get :show, params: { id: collection.id }
			expect(response).to have_http_status(200)
			expect(response).to render_template(:show)
		end

		it "lists only published posts" do
			collection = FactoryBot.create(:collection)
			live = FactoryBot.create(:post, collection: collection)
			draft = FactoryBot.create(:post, :unpublished, collection: collection)

			get :show, params: { id: collection.id }

			expect(assigns(:posts)).to include(live)
			expect(assigns(:posts)).not_to include(draft)
		end

		it "redirects a visitor away from an unpublished collection" do
			draft = FactoryBot.create(:collection, :unpublished)
			get :show, params: { id: draft.id }
			expect(response).to redirect_to(collections_path)
		end

		it "lets a signed-in admin preview an unpublished collection" do
			sign_in FactoryBot.create(:admin)
			draft = FactoryBot.create(:collection, :unpublished)
			get :show, params: { id: draft.id }
			expect(response).to have_http_status(200)
		end

		it "finds a collection by its slug" do
			collection = FactoryBot.create(:collection, :with_posts, title: "Learning Rust")
			get :show, params: { id: "learning-rust" }
			expect(assigns(:collection)).to eq(collection)
		end
	end

	describe "Admin Interactions" do

		before(:each) do
			@admin = FactoryBot.create(:admin)
			@collection = FactoryBot.create(:collection)
		end

		it "requires an admin to reach the new form" do
			get :new
			expect(response).not_to have_http_status(200)
		end

		it "renders the new form for an admin" do
			sign_in @admin
			get :new
			expect(response).to have_http_status(200)
			expect(response).to render_template(:new)
		end

		it "renders the edit form for an admin" do
			sign_in @admin
			get :edit, params: { id: @collection.id }
			expect(response).to have_http_status(200)
			expect(response).to render_template(:edit)
		end

		it "creates a collection" do
			sign_in @admin
			expect {
				post :create, params: { collection: { title: "A New Series", description: "Notes", published: true } }
			}.to change { Collection.count }.by(1)
			expect(response).to redirect_to(collections_url)
		end

		it "requires an admin to create a collection" do
			expect {
				post :create, params: { collection: { title: "Sneaky", published: true } }
			}.not_to change { Collection.count }
		end

		it "updates a collection" do
			sign_in @admin
			patch :update, params: { id: @collection.id, collection: { title: "Renamed" } }
			expect(@collection.reload.title).to eq("Renamed")
		end

		it "destroys a collection without destroying its posts" do
			sign_in @admin
			collection = FactoryBot.create(:collection, :with_posts, post_count: 2)

			expect {
				delete :destroy, params: { id: collection.id }
			}.not_to change { Post.count }

			expect(Collection.exists?(collection.id)).to eq(false)
		end
	end
end
