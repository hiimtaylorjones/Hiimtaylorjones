class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { maximum: 150 }
	validates :body, presence: true, length: { minimum: 5 }

	acts_as_taggable
end
