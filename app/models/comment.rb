class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :commenter
  validates_presence_of :body
end
