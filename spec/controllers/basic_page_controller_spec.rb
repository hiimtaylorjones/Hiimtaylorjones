require 'rails_helper'

RSpec.describe BasicPageController, :type => :controller do

	# The admin dashboard now renders a collections table; render it for real.
	render_views

	describe "GET #admin" do
		it "redirects a visitor who is not signed in" do
			get :admin
			expect(response).not_to have_http_status(200)
		end

		it "renders the dashboard with posts and collections for an admin" do
			sign_in FactoryBot.create(:admin)
			FactoryBot.create(:post)
			collection = FactoryBot.create(:collection, :with_posts, post_count: 2)

			get :admin

			expect(response).to have_http_status(200)
			expect(assigns(:collections)).to include(collection)
			expect(response.body).to include(collection.title)
		end

		it "lists unpublished collections for the admin too" do
			sign_in FactoryBot.create(:admin)
			draft = FactoryBot.create(:collection, :unpublished)

			get :admin

			expect(assigns(:collections)).to include(draft)
		end
	end

	describe "GET #refresh" do
		it "renders the markdown home page" do
			get :refresh
			expect(response).to have_http_status(200)
		end
	end
end
