require 'rails_helper'

RSpec.describe 'Admin sessions', type: :request do
	let(:password) { 'correct-horse-battery' }
	let!(:admin) { FactoryBot.create(:admin, email: 'admin@example.com', password: password, password_confirmation: password) }

	it 'renders the login form' do
		get new_admin_session_path
		expect(response).to have_http_status(200)
	end

	it 'signs in with valid credentials and lands on the dashboard' do
		post admin_session_path, params: { email: 'admin@example.com', password: password }
		expect(response).to redirect_to(admin_url)

		get admin_path
		expect(response).to have_http_status(200)
	end

	it 'matches the email case-insensitively' do
		post admin_session_path, params: { email: ' Admin@Example.com ', password: password }
		expect(response).to redirect_to(admin_url)
	end

	it 'rejects a wrong password' do
		post admin_session_path, params: { email: 'admin@example.com', password: 'nope' }
		expect(response).to redirect_to(new_admin_session_path)

		get admin_path
		expect(response).to redirect_to(new_admin_session_path)
	end

	it 'returns to the page that required a login' do
		get new_post_path
		post admin_session_path, params: { email: 'admin@example.com', password: password }
		expect(response).to redirect_to(new_post_url)
	end

	it 'signs out' do
		post admin_session_path, params: { email: 'admin@example.com', password: password }
		expect { delete destroy_admin_session_path }.to change(AdminSession, :count).by(-1)

		get admin_path
		expect(response).to redirect_to(new_admin_session_path)
	end

	# Devise wrote bcrypt hashes to encrypted_password, which the migration
	# renamed to password_digest. A hash stored that way must still log in.
	it 'accepts a password hash written by Devise' do
		admin.update_column(:password_digest, BCrypt::Password.create('legacy-password', cost: BCrypt::Engine::MIN_COST))

		post admin_session_path, params: { email: 'admin@example.com', password: 'legacy-password' }
		expect(response).to redirect_to(admin_url)
	end
end
