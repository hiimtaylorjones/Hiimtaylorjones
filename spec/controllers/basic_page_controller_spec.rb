require 'spec_helper'

describe BasicPageController do

  describe "GET 'index'" do
    it "Should return http success" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET 'blog'" do
    it "Should return http success" do
      get :blog
      response.should render_template :blog
    end
  end

  describe "GET 'resume'" do
    it "Should return http success" do
      get :resume
      response.should render_template :resume 
    end
  end

  describe "GET 'about'" do
    it "Should return http success" do
      get :about 
      response.should render_template :about
    end
  end

end
