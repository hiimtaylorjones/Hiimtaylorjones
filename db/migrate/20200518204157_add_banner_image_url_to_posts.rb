class AddBannerImageUrlToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :banner_image_url, :string
  end
end
