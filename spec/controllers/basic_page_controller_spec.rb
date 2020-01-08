require "rails_helper"

RSpec.describe BasicPageController, :type => :controller do
  describe "Index"
    describe "GET #index" do
      it "responds successfully with an HTTP 200 status code" do
        get :index
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

  describe "About"
    describe "GET #about" do
      it "responds successfully with an HTTP 200 status code" do
        get :about
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it "renders the about template" do
        get :about
        expect(response).to render_template("about")
      end
    end
end