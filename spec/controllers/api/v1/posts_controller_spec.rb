require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      @posts = FactoryGirl.create_list(:post, 5)
    end

    it 'should contain 5 posts' do
      get :index
      resp = JSON.parse(response.body)
      expect(resp.length).to eql @posts.count
    end
  end

  describe 'Show Post' do
    before(:each) do
      @post = FactoryGirl.create(:post)
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :show, id: @post.id
      resp = JSON.parse(response.body)
      expect(resp['title']).to eql @post.title
    end
  end

  describe 'Admin Interacitons' do
    before(:each) do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @post = FactoryGirl.create(:post)
    end

    it 'should authenticate the user and allow editing' do
      get :edit, id: @post
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'should authenticate the user and allow post creation' do
      post :create, post: FactoryGirl.attributes_for(:post)
      resp = JSON.parse(response.body)
      expect(resp['id']).to_not be_nil
    end
  end
end
