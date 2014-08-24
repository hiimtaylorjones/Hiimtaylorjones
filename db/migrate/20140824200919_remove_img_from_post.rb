class RemoveImgFromPost < ActiveRecord::Migration
  def change
  	remove_column :posts, :img, :string
  end
end
