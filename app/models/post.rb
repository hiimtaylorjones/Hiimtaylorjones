# A post written by an admin for usage on the site

class Post < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	has_many :comments, dependent: :destroy
	has_one_attached :banner_image

	validates :title, presence: true, length: { maximum: 150 }
	validates :body, presence: true, length: { minimum: 5 }

end
