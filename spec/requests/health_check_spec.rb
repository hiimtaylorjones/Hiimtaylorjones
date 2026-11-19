require 'rails_helper'

# /up used to sit below the catch-all route, so it redirected to root instead of reporting health.
RSpec.describe 'Health check', type: :request do
  it 'responds with 200 at /up' do
    get '/up'
    expect(response).to have_http_status(200)
  end
end
