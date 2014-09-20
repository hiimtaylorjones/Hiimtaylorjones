class AddTitleImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title_image, :string
  end
end
