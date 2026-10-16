class Collection < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	# Prevents deleting posts in an `collection.destroy!` operation`
	has_many :posts, dependent: :nullify

	validates :title, presence: true, length: { maximum: 150 }

	# Active means that a collection of posts is visible. The posts' visibility don't 
	# depend on this status to be shown or not. 
	scope :active, -> { where(active: true) }

	scope :listable, -> {
		active.joins(:posts).where(posts: { published: true }).distinct
	}
end
