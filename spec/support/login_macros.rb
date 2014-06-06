module LoginMacros
	def set_user_session(user)
		session[:user_di] = user.id
	end

	def sign_in(user)
		visit root_path
		click_link 'Log In'
		fill_in 'Email', with: user.Email
		fill_in 'Password', with: user.Password
		click_button 'Log In'
	end
end