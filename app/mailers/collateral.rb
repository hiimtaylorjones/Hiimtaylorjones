class Collateral < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`s
  default from: "noreply@everythingiscollateral.com"

  def welcome_email(user)
  	@user = user
  	@url = 'http://everythingiscollateral.com/login'
  	mail(to: @user.email, subject: 'Welcome to Everything is Collateral')
  end
end
