class BasicPageController < ApplicationController

  def index
  end

  def blog
  end

  def about
    @page = Page.find(1)
  end

  def admin
    @users = User.all 
    @posts = Post.order('created_at DESC')
    @pages = Page.all
    @inquiries = Inquiry.all
  end

  def taylor
  end
end
