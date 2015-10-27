class BasicPageController < ApplicationController

  def index
    @posts = Post.where(published: true)
    @posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end

  def about
    @content = Page.where(title: "About")
  end
  
  def admin
    authenticate_admin!
    @admins = Admin.all
    @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @pages = Page.all
    @inquiries = Inquiry.all
  end

end
