class AddAttachmentTitleImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :title_image
    end
  end

  def self.down
    remove_attachment :posts, :title_image
  end
end
