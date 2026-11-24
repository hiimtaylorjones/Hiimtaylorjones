# Admin login and logout.
class AdminSessionsController < ApplicationController
  # Slows password guessing; Devise had no equivalent configured.
  rate_limit to: 10, within: 3.minutes, only: :create,
             with: -> { redirect_to new_admin_session_path, alert: "Too many attempts. Try again later." }

  def new
  end

  def create
    if (admin = Admin.authenticate_by(params.permit(:email, :password)))
      start_new_session_for admin
      redirect_to after_authentication_url
    else
      redirect_to new_admin_session_path, alert: "Invalid email or password."
    end
  end

  def destroy
    resume_session
    terminate_session
    redirect_to root_path, notice: "Signed out."
  end
end
