require 'spec_helper'

describe PostsController do
	describe "GET #index" do
		it "populates an array of posts" do
			post = FactoryGirl.create(:post)
			get :index
			assigns(:posts).should eq([post])
		end
		it "renders the :index view" do
			get :index
			response.should render_template :index
		end
	end

	describe "GET #show" do
		it "assigns the requested Post to @post" do
			post = FactoryGirl.create(:post)
			get :show, id: post 
			assigns(:post).should eq(post)
		end
		it "renders the :show template" do
			get :show, id: FactoryGirl.create(:post)
			response.should render_template :show
		end
	end

	describe "GET #new" do
	 	it "assigns a new Post to @post"
	 	it "renders the :new template"
	end

	describe "POST #create" do
		context "with valid attributes" do
	 		it "saves the new post in the database" do
	 			expect{ 
	 				post :create, post: FactoryGirl.attributes_for(:post) 
	 			}.to change(Post,:count).by(1)
	 		end
	 		it "redirects to the blog listing page" do
	 			post :create, post: FactoryGirl.attributes_for(:post)
	 		end
	 	end
	 	context "with invalid attributes" do
	 		it "does not save the new post in the database" do
	 			expect {
	 				post :create, post: FactoryGirl.attributes_for(:invalid_post)
	 			}.to_not change(Post, :count)
	 		end
	 		it "re-renders the :new template" do 
	 			post :create, post: FactoryGirl.attributes_for(:invalid_post)
	 			response.should render_template :new
	 		end
	 	end
	end

	describe "PUT update" do
		before :each do 
			@post = FactoryGirl.create(:post, title: "Testing Now.", text: "Hello my friends.")
		end

		context "valid attributes" do
			it "located the requested @post" do 
				put :update, id: @post, post: FactoryGirl.attributes_for(:post)
				assigns(:post).should eq(@post)
			end

			it "changes the @post's attributes" do 
				put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: "Running Tests.", text: "Right right now.")
				@post.reload
				@post.title.should eq("Running Tests.")
				@post.text.should eq("Right right now.")
			end
			it "redirects to the updated post" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:post)
				response.should redirect_to @post
			end
		end
		context "invalid attributes" do 
			it "locates the requested @post" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
				assigns(:post).should eq(@post)
			end
			it "does not change @post's attributes" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: nil, text: "Yeah. Something like that.")
				@post.reload
				@post.title.should_not eq(nil)
				@post.text.should_not eq("Yeah. Something like that.")
			end
			it "re-renders the edit method" do
				put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
				response.should render_template :edit
			end
		end
	end

	describe "DELETE destroy" do
		before :each do 
			@post = FactoryGirl.create(:post)
		end

		it "deletes the post" do
			expect {
				delete :destroy, id: @post
			}.to change(Post, :count).by(-1)
		end

		it "redirects to posts#index" do 
			delete :destroy, id: @post
			response.should redirect_to posts_url
		end
	end
end
