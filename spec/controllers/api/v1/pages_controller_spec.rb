require 'rails_helper'

RSpec.describe Api::V1::PagesController, type: :controller do

  describe "Page Index" do

    before(:all) do 
      @admin = Admin.find_by(email: "admin@hiimtaylorjones.com")
      sign_in @admin
    end

    before(:each) do
      created_factory = FactoryBot.create_list(:page, 10)
      @pages = Page.last(5)
		end

    after(:all) do 
      sign_out @admin 
    end

	  describe "GET #index" do
	    it "responds with a 200 status code and JSON formatting" do
	      get :index
	      expect(response).to be_successful
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
    
    describe "PUT #update" do
      before(:all) do
        @page = FactoryBot.create(:page) 
      end

      context "Golden Path" do
        it "responds with a 200 status code" do
          put :update, params: { 
            id: @page.id,
            page: {
              title: "New Title",
              content: "New Content"
            }
          }
          parsed_body = JSON.parse(response.body)
          status = parsed_body["status"]
          page = parsed_body["page"]
          expect(status).to eq(200)
          expect(page["title"]).to eq("New Title")
          expect(page["content"]).to eq("New Content")
        end
      end

      context "Faulty path" do
        
        it "responds with a 404 status code" do
          put :update, params: { 
            id: @page.id + 55,
            page: {
              title: "New Title",
              content: "New Content"
            }
          }
          parsed_body = JSON.parse(response.body)
          status = parsed_body["status"]
          page = parsed_body["page"]
          expect(status).to eq(404)
          expect(page).to eq(nil)
        end
      end
    end

  end

end
