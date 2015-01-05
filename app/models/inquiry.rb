class Inquiry < ActiveRecord::Base
	validates :name, presence: true
	validates :company, presence: true
	validates :email, presence: true
	validates :phone, presence: true
	validates :job_description, presence: true
	validates :finish_date, presence: true
end
