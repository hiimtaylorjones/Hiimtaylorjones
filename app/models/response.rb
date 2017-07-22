# A response to a comment written by an admin.

class Response < ActiveRecord::Base
  belongs_to :comment
  validates :message, presence: true
end
