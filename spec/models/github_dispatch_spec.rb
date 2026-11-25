require 'rails_helper'

RSpec.describe GithubDispatch do
	around do |example|
		original = ENV['GITHUB_DISPATCH_TOKEN']
		ENV['GITHUB_DISPATCH_TOKEN'] = 'test-token'
		example.run
	ensure
		ENV['GITHUB_DISPATCH_TOKEN'] = original
	end

	# Stands in for the HTTPS connection; records the request it was given.
	let(:http) { double('http') }
	let(:sent) { [] }

	def respond_with(response)
		allow(Net::HTTP).to receive(:start).with('api.github.com', 443, hash_including(use_ssl: true)).and_yield(http)
		allow(http).to receive(:request) { |request| sent << request; response }
	end

	it 'posts a repository_dispatch event with the token' do
		respond_with(Net::HTTPNoContent.new('1.1', '204', 'No Content'))

		described_class.deliver('heroku-build', { build_id: 'build-1' })

		request = sent.first
		expect(request.path).to eq("/repos/#{GithubDispatch::REPOSITORY}/dispatches")
		expect(request['Authorization']).to eq('Bearer test-token')
		expect(JSON.parse(request.body)).to eq('event_type' => 'heroku-build', 'client_payload' => { 'build_id' => 'build-1' })
	end

	it 'raises when GitHub refuses the dispatch' do
		respond_with(Net::HTTPUnprocessableEntity.new('1.1', '422', 'Unprocessable'))
		expect { described_class.deliver('heroku-build', {}) }.to raise_error(GithubDispatch::Error, /422/)
	end

	it 'raises when GitHub cannot be reached' do
		allow(Net::HTTP).to receive(:start).and_raise(Net::OpenTimeout)
		expect { described_class.deliver('heroku-build', {}) }.to raise_error(GithubDispatch::Error)
	end

	it 'raises without a token' do
		ENV['GITHUB_DISPATCH_TOKEN'] = nil
		expect { described_class.deliver('heroku-build', {}) }.to raise_error(GithubDispatch::Error, /GITHUB_DISPATCH_TOKEN/)
	end
end
