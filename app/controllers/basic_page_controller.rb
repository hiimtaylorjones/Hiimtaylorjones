class BasicPageController < ApplicationController
  before_action :authenticate_admin!, only: :admin

  def index
    @posts = Post.published
    @posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 1)
  end

  def admin
    @admins = Admin.all
    @posts = Post.includes(:collection).paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @collections = Collection.order('created_at DESC')
  end

  def resume
    @content_class = "resume"
  end

end
