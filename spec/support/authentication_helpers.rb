# Stands in for Devise's sign_in test helper: creates a session row and sets
# the signed cookie the Authentication concern reads.
module AuthenticationHelpers
  def sign_in(admin)
    cookies.signed[:admin_session_id] = admin.admin_sessions.create!.id
  end
end
