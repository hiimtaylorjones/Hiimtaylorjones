# A page that displays information

class Page < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	validates :title, :content, presence: true
	validate :check_placement

	def check_placement
		return ["none", "navbar", "submenu"].include?(self.placement)
	end
end
