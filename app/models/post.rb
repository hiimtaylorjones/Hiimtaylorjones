# A post written by an admin for usage on the site

class Post < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	has_one_attached :banner_image

	# `optional` is required, not stylistic: belongs_to is mandatory by default in
	# Rails 5+, and most posts have no collection.
	belongs_to :collection, optional: true

	validates :title, presence: true, length: { maximum: 150 }
	validates :body, presence: true, length: { minimum: 5 }

	scope :published, -> { where(published: true) }

end
