# Per-request state, reset automatically between requests.
class Current < ActiveSupport::CurrentAttributes
  attribute :admin_session
  delegate :admin, to: :admin_session, allow_nil: true
end
