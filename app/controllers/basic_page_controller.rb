class BasicPageController < ApplicationController

  def index
    @posts = Post.where(published: true)
    @posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 1)
  end

  def admin
    authenticate_admin!
    @admins = Admin.all
    @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def refresh
  end

  def resume
    @content_class = "resume"
  end

end
