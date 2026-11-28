# The site's administrator. Admins write posts and manage collections; only one
# exists in practice. Passwords are bcrypt hashes via has_secure_password.

class Admin < ApplicationRecord
  has_secure_password
  has_many :admin_sessions, dependent: :destroy

  # Lets "Admin@Example.com " match the stored address at login.
  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, allow_nil: true
end
