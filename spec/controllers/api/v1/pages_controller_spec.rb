require 'rails_helper'

RSpec.describe Api::V1::PagesController, type: :controller do

  describe "Page Index" do

    before(:each) do
      created_factory = FactoryBot.create_list(:page, 10)
      @pages = Page.last(5)
		end

	  describe "GET #index" do
	    it "responds with a 200 status code and JSON formatting" do
	      get :index
	      expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq("application/json")
	    end


      it "returns 10 records if not specified by filtering" do 
        get :index, params: { page: 1 }
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["data"].length).to eq(10)
      end

	    it "respects pagination filtering" do
        get :index, params: { page: 1, per_page: 5 }
        parsed_body = JSON.parse(response.body)
        expect(parsed_body["data"].length).to eq(5)
        expect(parsed_body["data"][0]["title"]).to eq(@pages.first.title)
        expect(parsed_body["data"][0]["content"]).to eq(@pages.first.content)
	    end
	  end
  end

end
