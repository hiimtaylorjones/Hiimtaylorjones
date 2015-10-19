class PostsController < ApplicationController

	before_action :authenticate_admin!, only: [:create, :new, :edit, :update, :destroy]

	def new
		@post = Post.new
	end

	def create
  		@post = Post.new(post_params)
	 		if @post.save
	  		redirect_to posts_url, notice: 'Post was successfully created.'
	  	else
	  		render action: "new"
	  	end
	end

	def show
  	if Post.where(:id => params[:id], :published => true).present?
  		@post = Post.find(params[:id])
  		authorize! :show, @post
		else
  		@post = Post.find(params[:id])
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to admin_path
	end

	def index
		@posts = Post.where(published: false)
		@posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
	end

	def edit
		@post = Post.find(params[:id])
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
			params.require(:post).permit(:title, :tagline, :published, :title_image, :text, :tag_list)
		end
end
