module ControllerMacros
  def login_user
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
      return user
  end

  def signout_user

  end
end