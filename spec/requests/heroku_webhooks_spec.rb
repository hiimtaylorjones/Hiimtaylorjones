require 'rails_helper'

RSpec.describe 'Heroku webhooks', type: :request do
	let(:secret) { 'webhook-secret' }
	let(:build_finished) do
		{
			resource: 'build',
			action: 'update',
			data: { id: 'build-1', status: 'succeeded', source_blob: { version: 'abc123' } }
		}.to_json
	end

	around do |example|
		original = ENV['HEROKU_WEBHOOK_SECRET']
		ENV['HEROKU_WEBHOOK_SECRET'] = secret
		example.run
	ensure
		ENV['HEROKU_WEBHOOK_SECRET'] = original
	end

	# Signs a body the way Heroku does.
	def signature(body, key = secret)
		Base64.strict_encode64(OpenSSL::HMAC.digest('SHA256', key, body))
	end

	def deliver(body, sig = signature(body))
		post heroku_webhooks_path, params: body,
		     headers: { 'Content-Type' => 'application/json', 'Heroku-Webhook-Hmac-SHA256' => sig }
	end

	it 'forwards a finished build to GitHub and returns 204' do
		expect(GithubDispatch).to receive(:deliver)
			.with('heroku-build', { build_id: 'build-1', sha: 'abc123', status: 'succeeded' })

		deliver(build_finished)

		expect(response).to have_http_status(:no_content)
	end

	it 'accepts an event it ignores without calling GitHub' do
		expect(GithubDispatch).not_to receive(:deliver)
		deliver({ resource: 'dyno', action: 'create', data: {} }.to_json)
		expect(response).to have_http_status(:no_content)
	end

	it 'rejects a bad signature' do
		expect(GithubDispatch).not_to receive(:deliver)
		deliver(build_finished, signature(build_finished, 'wrong-secret'))
		expect(response).to have_http_status(:unauthorized)
	end

	it 'rejects a missing signature' do
		post heroku_webhooks_path, params: build_finished, headers: { 'Content-Type' => 'application/json' }
		expect(response).to have_http_status(:unauthorized)
	end

	it 'refuses everything while no secret is configured' do
		ENV['HEROKU_WEBHOOK_SECRET'] = nil
		deliver(build_finished)
		expect(response).to have_http_status(:service_unavailable)
	end

	it 'rejects a signed body that is not JSON' do
		deliver('not json')
		expect(response).to have_http_status(:bad_request)
	end

	# Heroku retries a sync-level delivery on any non-2xx response.
	it 'returns 502 when GitHub cannot be reached, so Heroku retries' do
		allow(GithubDispatch).to receive(:deliver).and_raise(GithubDispatch::Error, 'GitHub returned 503')
		deliver(build_finished)
		expect(response).to have_http_status(:bad_gateway)
	end

	it 'does not need a CSRF token' do
		allow(GithubDispatch).to receive(:deliver)
		ActionController::Base.allow_forgery_protection = true
		deliver(build_finished)
		expect(response).to have_http_status(:no_content)
	ensure
		ActionController::Base.allow_forgery_protection = false
	end
end
