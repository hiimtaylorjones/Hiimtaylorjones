class BasicPageController < ApplicationController

  def index
  end

  def blog
  end

  def about
  end

  def admin
    @users = User.all 
    @posts = Post.all
    authorize! :show, @posts
    authorize! :show, @users
  end

  def taylor
  end
end
