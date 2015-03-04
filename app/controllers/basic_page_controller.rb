class BasicPageController < ApplicationController

  def index
    @posts = Post.where(draft: false)
    @posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
  end

  def about
    @page = Page.find(1)
  end

  def admin
    @users = User.all 
    @posts = Post.order('created_at DESC')
    @pages = Page.all
    @inquiries = Inquiry.all
    authorize! :show, @posts
    authorize! :show, @users
    authorize! :show, @pages
  end

end
