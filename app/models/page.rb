# A page that displays information

class Page < ActiveRecord::Base
	validates :title, :content, presence: true
end
