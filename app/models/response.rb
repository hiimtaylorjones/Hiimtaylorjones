class Response < ActiveRecord::Base
  belongs_to :comment
  validates :message, presence: true
end
