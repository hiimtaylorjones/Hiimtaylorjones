class BasicPageController < ApplicationController

  def index
    @posts = Post.where(published: true)
    @posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end

  def about
    @page = Page.find(1)
  end

  def admin
    authenticate_user!
    @users = User.all
    @posts = Post.order('created_at DESC')
    @pages = Page.all
    @inquiries = Inquiry.all
  end

end
