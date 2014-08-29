
class RemovePaperclip < ActiveRecord::Migration
  def change
  	remove_attachment :posts, :title_image
  	remove_attachment :users, :avatar
  end
end
