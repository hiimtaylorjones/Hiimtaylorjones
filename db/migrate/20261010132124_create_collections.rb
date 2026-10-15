# A Collection groups posts into a named series. A post belongs to at most one
# collection, so this is a plain nullable FK on posts rather than a join table.
class CreateCollections < ActiveRecord::Migration[8.0]
  def change
    create_table :collections do |t|
      t.string  :title, null: false
      t.string  :slug
      t.text    :description
      # `active`, not `published`: this is not a page-visibility flag. An
      # inactive collection's grouping simply does not apply — its posts read
      # as unclassified. Post#published remains the authority on a post.
      t.boolean :active, default: false, null: false

      t.timestamps
    end

    add_index :collections, :slug, unique: true

    # Nullable: standalone posts are the common case, and every existing row
    # starts out with no collection.
    add_reference :posts, :collection, foreign_key: true, null: true, index: true
  end
end
