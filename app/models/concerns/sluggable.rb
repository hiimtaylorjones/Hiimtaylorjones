# Gives a model a URL slug built from its title, replacing the friendly_id gem.
# The slug is set once and kept when the title changes, so published links
# never break.
module Sluggable
  extend ActiveSupport::Concern

  # Slugs that would clash with routes such as /posts/new.
  RESERVED_SLUGS = %w[new edit index session login logout users admin
                      stylesheets assets javascripts images].freeze

  included do
    before_validation :generate_slug, if: -> { slug.blank? && title.present? }
    validates :slug, exclusion: { in: RESERVED_SLUGS, message: "is reserved" }
  end

  class_methods do
    # Looks up by slug first, then by numeric id so old /posts/12 links work.
    def find_by_slug_or_id!(param)
      find_by(slug: param) || find(param)
    end
  end

  # Uses the saved slug, so a form that fails validation still links correctly.
  def to_param
    slug_in_database.presence || super
  end

  private
    # A duplicate title gets a UUID suffix, as friendly_id did.
    def generate_slug
      candidate = title.parameterize
      candidate = "#{candidate}-#{SecureRandom.uuid}" if self.class.where.not(id: id).exists?(slug: candidate)
      self.slug = candidate
    end
end
