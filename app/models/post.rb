# A post written by an admin for usage on the site

class Post < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	validate :check_tag_length

	has_many :comments, dependent: :destroy
	has_one_attached :banner_image

	validates :title, presence: true, length: { maximum: 150 }
	validates :body, presence: true, length: { minimum: 5 }

	acts_as_taggable

private 

	def check_tag_length
		self.tag_list.each do |tag|
			if tag.length > 12
				errors.add(:base, "Tag list can't have tags greater than 12 characters.")
			end
		end
	end
	
end
