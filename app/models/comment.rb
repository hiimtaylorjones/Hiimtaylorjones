# A comment to be left on a Post object.

class Comment < ActiveRecord::Base
	belongs_to :post
	validates :name, :email, :message, presence: true

	has_one :response
end
