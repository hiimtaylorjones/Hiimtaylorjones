class Comment < ActiveRecord::Base
	belongs_to :post
	validates :name, presence: true
	validates :email, presence: true
	validates :message, presence: true
end
