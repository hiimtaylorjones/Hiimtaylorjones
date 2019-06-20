class AddCommentsEnabledToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :commenting_enabled, :boolean, default: false
  end
end
