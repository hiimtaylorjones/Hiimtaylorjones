class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login
  before_save :set_role
  validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

  # User::Roles
  # The available roles
  ROLES = %w[default admin]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

  def self.find_first_by_auth_conditions(warden_conditions)
  	conditions = warden_conditions.dup
  	if login = conditions.delete(:login)
    	where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
  	else
    	where(conditions).first
  	end
  end

  private 
    def set_role
      self.role = "default"
    end
end
