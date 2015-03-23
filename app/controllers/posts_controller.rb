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
		
  		if Post.where(:id => params[:id], :draft => true).present?
  			@post = Post.find(params[:id])
  			authorize! :show, @post
		else
  			@post = Post.find(params[:id])
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		authorize! :manage, @post
		redirect_to admin_path
	end

	def index
		@posts = Post.where(draft: false)
		@posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
	end

	def edit
		@post = Post.find(params[:id])
		authorize! :manage, @post
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			redirect_to admin_path 
		else
			render 'edit'
		end
	end

	private
		def post_params
			params.require(:post).permit(:title, :tagline, :draft, :title_image, :text)
		end
end

