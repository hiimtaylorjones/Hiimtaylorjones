# A named grouping of posts, e.g. a multi-part series.

class Collection < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	# Nullify, not destroy: deleting a grouping must never delete the writing
	# inside it. Member posts fall back to standalone.
	has_many :posts, dependent: :nullify

	validates :title, presence: true, length: { maximum: 150 }

	scope :published, -> { where(published: true) }

	# Published collections that actually have something to show. Keeps
	# dead-end pages off the index without making them unreachable by URL.
	scope :with_published_posts, -> {
		published.joins(:posts).where(posts: { published: true }).distinct
	}
end
