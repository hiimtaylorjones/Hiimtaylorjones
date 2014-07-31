class PostsController < ApplicationController

	load_and_authorize_resource
  	skip_authorize_resource :only => :index
  	skip_authorize_resource :only => :show

	def new
		@post = Post.new
	end

	def create
  		@post = Post.new(post_params)
  		respond_to do |format| 
	 		if @post.save
	  			format.html { redirect_to posts_url, 
	  				notice: 'Post was successfully created.' }
	  			format.json {render json: @post, status: created,
	  				location: @post}
	  		else
	  			format.html { render action: "new" }
	  			format.json { render json: @post.errors, 
	  				status: :unprocessable_entity }
	  		end
	  	end
	end

	def show
		@post = Post.find(params[:id])
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		authorize! :manage, @post
		render 'admin'
	end

	def index
		@posts = Post.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
	end

	def edit
		@post = Post.find(params[:id])
		authorize! :manage, @post
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to @post 
		else
			render 'edit'
		end
	end

	def admin
		@posts = Post.all
		authorize! :show, @posts
	end

	private
		def post_params
			params.require(:post).permit(:title, :img, :text, :tagline)
		end
end

