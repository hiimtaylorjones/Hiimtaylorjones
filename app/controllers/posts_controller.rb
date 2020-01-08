class PostsController < ApplicationController

	before_action :authenticate_admin!, only: [:create, :new, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy]

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
		@not_linkable = true
  	if @post.published == false
			redirect_to :back, notice: "The post you're trying to look at hasn't been published yet!"
		end
	end

	def destroy
		@post.destroy
		redirect_to admin_path
	end

	def index
		@page = if params[:page].present?
			params[:page]
		else
			1
		end
		
		@posts = Post.where(published: true)
		@at_last_page = (@posts.count / 10) == @page
		@posts = @posts.order('created_at DESC').paginate(:page => @page, :per_page => 10)
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to admin_path
		else
			render 'edit'
		end
	end

	private

		def find_post
			@post = Post.friendly.find(params[:id])
		end

		def post_params
			params.require(:post).permit(:title, :tagline, :published, :body, :tag_list)
		end
end
