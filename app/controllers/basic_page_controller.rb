class BasicPageController < ApplicationController

  def index
    @posts = Post.where(published: true)
    @posts = @posts.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
  end

  def about
    @page = Page.find_by(title: "About")
    render layout: "page"
  end

  def writing
    @page = Page.find_by(title: "Writing")
    render layout: "page"
  end

  def speaking
    @page = Page.find_by(title: "Speaking")
    render layout: "page"
  end

  def admin
    authenticate_admin!
    @admins = Admin.all
    @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC')
    @pages = Page.all
    render layout: "page"
  end

end
