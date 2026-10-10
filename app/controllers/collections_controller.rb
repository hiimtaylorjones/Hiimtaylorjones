class CollectionsController < ApplicationController

	before_action :authenticate_admin!, only: [:create, :new, :edit, :update, :destroy]
	before_action :find_collection, only: [:show, :edit, :update, :destroy]

	def new
		@collection = Collection.new
	end

	def create
		@collection = Collection.new(collection_params)
		if @collection.save
			redirect_to collections_url, notice: 'Collection was successfully created.'
		else
			render action: "new"
		end
	end

	def show
		unless @collection.published? || admin_signed_in?
			redirect_to collections_path, notice: "The collection you're trying to look at hasn't been published yet!"
			return
		end

		# A draft post never surfaces through its collection, even to an admin.
		@posts = @collection.posts.published
		                    .order('created_at DESC')
		                    .paginate(page: params[:page], per_page: 10)
	end

	def index
		@collections = Collection.with_published_posts.order('created_at DESC')
	end

	def edit
	end

	def update
		if @collection.update(collection_params)
			redirect_to edit_collection_path(@collection), notice: "Collection was successfully updated"
		else
			render :edit
		end
	end

	def destroy
		@collection.destroy
		redirect_to admin_path
	end

	private

		def find_collection
			@collection = Collection.friendly.find(params[:id])
		end

		def collection_params
			params.require(:collection).permit(:title, :description, :published)
		end
end
