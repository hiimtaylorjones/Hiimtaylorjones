require 'rails_helper'

RSpec.describe Api::V1::PagesController, type: :controller do

  describe 'Show page' do
    before(:each) do
      @page = FactoryGirl.create(:page)
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :show, id: @page.id
      resp = JSON.parse(response.body)
      expect(resp['title']).to eql @page.title
    end
  end

  describe 'Admin Interacitons' do
    before(:each) do
      @admin = FactoryGirl.create(:admin)
      sign_in @admin
      @page = FactoryGirl.create(:page)
    end

    context 'Editing a page' do
      it 'should authenticate the user and allow editing' do
        get :edit, id: @page
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end
end
