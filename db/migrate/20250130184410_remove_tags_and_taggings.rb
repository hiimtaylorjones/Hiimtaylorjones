class RemoveTagsAndTaggings < ActiveRecord::Migration[7.0]
  def up
    drop_table :taggings
    drop_table :tags
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
