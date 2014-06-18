class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # helper_method :current_user, :current_admin

  # def authorize_user
  #   redirect_to login_url, alert: "Not logged in as a user. Please log in." if current_user.nil? && current_admin.nil?
  # end

  # def authorize_admin
  #   redirect_to admin_login_url, alert: "Not authorized." if current_admin.nil?
  # end

  # private
  # 	def current_user
  #   	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  # 	end

  #   def current_admin
  #     @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  #   end
end
