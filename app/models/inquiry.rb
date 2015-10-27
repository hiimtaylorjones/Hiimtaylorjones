class Inquiry < ActiveRecord::Base
	validates :name, presence: true
	validates :company, presence: true
	validates :email, presence: true
end
