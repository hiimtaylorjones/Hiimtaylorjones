# Cookie-based admin login, adapted from Rails 8's authentication generator.
# Keeps Devise's helper names (authenticate_admin!, admin_signed_in?,
# current_admin) so controllers and views did not need to change.
module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :admin_signed_in?, :current_admin
  end

  private
    def admin_signed_in?
      current_admin.present?
    end

    def current_admin
      resume_session&.admin
    end

    # before_action guard: send visitors to the login page, then back here.
    def authenticate_admin!
      resume_session || request_authentication
    end

    def resume_session
      Current.admin_session ||= find_session_by_cookie
    end

    def find_session_by_cookie
      id = cookies.signed[:admin_session_id]
      AdminSession.find_by(id: id) if id
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url if request.get?
      redirect_to new_admin_session_path
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || admin_url
    end

    def start_new_session_for(admin)
      admin.admin_sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |admin_session|
        Current.admin_session = admin_session
        cookies.signed.permanent[:admin_session_id] = { value: admin_session.id, httponly: true, same_site: :lax }
      end
    end

    def terminate_session
      Current.admin_session&.destroy
      cookies.delete(:admin_session_id)
    end
end
