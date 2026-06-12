# A post written by an admin for usage on the site

class Post < ActiveRecord::Base
	extend FriendlyId
  friendly_id :title, use: :slugged

	has_many :comments, dependent: :destroy
	has_one_attached :banner_image

	validates :title, presence: true, length: { maximum: 150 }
	validate :body_content_present

	def body
		return File.read(body_file_path) if File.exist?(body_file_path)
		self[:body]
	end

	def body_file_path
		Rails.root.join("db", "posts", "#{slug}.md")
	end

	private

	def body_content_present
		return unless persisted?  # slug doesn't exist yet on new records
		return if File.exist?(body_file_path)
		return if self[:body].present? && self[:body].length >= 5
		errors.add(:body, "must be present (add a file at db/posts/#{slug}.md or provide body text)")
	end

end
