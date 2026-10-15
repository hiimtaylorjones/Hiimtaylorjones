# A named grouping of posts, e.g. a multi-part series.
#
# `active` is a statement about the grouping, not about page visibility: an
# inactive collection's grouping does not apply, so its member posts read as
# unclassified everywhere a visitor can see. Post#published stays the sole
# authority on whether a post itself is readable.
#
# Deactivating is therefore a reversible un-grouping — membership rows survive,
# so flipping `active` back reassembles the series. Destroying is the
# irreversible version, and nullifies rather than cascading.

class Collection < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	# Nullify, not destroy: deleting a grouping must never delete the writing
	# inside it. Member posts fall back to standalone.
	has_many :posts, dependent: :nullify

	validates :title, presence: true, length: { maximum: 150 }

	scope :active, -> { where(active: true) }

	# What a visitor should see on the index: an active grouping that actually
	# has something to show. Keeps dead-end pages off the listing without
	# making them unreachable by URL.
	scope :listable, -> {
		active.joins(:posts).where(posts: { published: true }).distinct
	}
end
