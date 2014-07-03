class Post < ActiveRecord::Base
	# Comment implementation - Saved for later.
	belongs_to :admin
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: { maximum: 50 }
	validates :text, presence: true, length: { minimum: 5 }
	# validates :img, presence: true
end
