class Post < ActiveRecord::Base
	belongs_to :admin
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: { maximum: 50 }
	validates :text, presence: true, length: { minimum: 5 }
	has_attached_file :title_image, :styles => { :desktop => "1020x504>", :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :title_image, :content_type => /\Aimage\/.*\Z/
  	validates_with AttachmentPresenceValidator, :attributes => :title_image
  	validates_with AttachmentSizeValidator, :attributes => :title_image, :less_than => 5.megabytes

end
