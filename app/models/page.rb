# A page that displays information

class Page < ActiveRecord::Base
	validates :title, :content, presence: true
	validate :check_placement

	def check_placement
		return ["none", "navbar", "submenu"].include?(self.placement)
	end
end
