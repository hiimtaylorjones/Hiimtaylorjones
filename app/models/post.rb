class Post < ActiveRecord::Base
	validates :title, presence: true, length: { maximum: 50 }
	validates :text, presence: true, length: { minimum: 5 }
end
