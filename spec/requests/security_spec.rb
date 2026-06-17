require 'rails_helper'

RSpec.describe 'Security', type: :request do
  describe 'Content-Security-Policy header' do
    it 'is present on page loads' do
      get root_path
      expect(response.headers['Content-Security-Policy']).to be_present
    end

    it "blocks object embeds" do
      get root_path
      expect(response.headers['Content-Security-Policy']).to include("object-src 'none'")
    end

    it "restricts scripts to self" do
      get root_path
      expect(response.headers['Content-Security-Policy']).to include("script-src 'self'")
    end

    it 'is present on post pages' do
      post = FactoryBot.create(:post)
      get post_path(post)
      expect(response.headers['Content-Security-Policy']).to be_present
    end
  end

  describe 'Parameter log filtering' do
    let(:filter) { ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters) }

    it 'filters password from logs' do
      result = filter.filter(password: 'hunter2', email: 'admin@example.com')
      expect(result[:password]).to eq('[FILTERED]')
      expect(result[:email]).to eq('admin@example.com')
    end

    it 'filters token values from logs' do
      result = filter.filter(reset_password_token: 'abc123', title: 'My Post')
      expect(result[:reset_password_token]).to eq('[FILTERED]')
      expect(result[:title]).to eq('My Post')
    end

    it 'filters secret values from logs' do
      result = filter.filter(secret: 'mysecret', body: 'post content')
      expect(result[:secret]).to eq('[FILTERED]')
      expect(result[:body]).to eq('post content')
    end

    it 'filters OTP values from logs' do
      result = filter.filter(otp: '123456', email: 'admin@example.com')
      expect(result[:otp]).to eq('[FILTERED]')
      expect(result[:email]).to eq('admin@example.com')
    end

    it 'filters private key values from logs' do
      result = filter.filter(api_key: 'sk-secret', name: 'Taylor')
      expect(result[:api_key]).to eq('[FILTERED]')
      expect(result[:name]).to eq('Taylor')
    end
  end
end
