require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  before do 
    admin = Admin.create!(email: "hello1234@eic.com", password: "passingpassword!")
    sign_in admin
  end

  before(:all) do
    @page = FactoryBot.create(:page, published: true)
  end

  describe "Display page" do

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { title: @page.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, params: { title: @page.title }
      expect(response).to render_template(:show)
    end
  end
end
