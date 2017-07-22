# Devise-based administrator for usage in the application. Admins can write posts,
# create comments, and basically manage the entire application at large.s

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
