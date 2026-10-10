# Comments were already unreachable before this migration: the Comment and
# Response models had no controller, no routes and no views. This removes the
# tables behind them.
#
# The create_table blocks are supplied so a rollback restores the original
# structure rather than raising IrreversibleMigration. Row data is not
# recoverable by rollback.
class DropCommentsAndResponses < ActiveRecord::Migration[8.0]
  def change
    # Dropped first: responses references comments via comment_id.
    drop_table :responses, id: :serial do |t|
      t.integer  :comment_id
      t.text     :message
      t.datetime :created_at, precision: nil, null: false
      t.datetime :updated_at, precision: nil, null: false

      t.index [:comment_id], name: "index_responses_on_comment_id"
    end

    drop_table :comments, id: :serial do |t|
      t.integer  :post_id
      t.datetime :created_at, precision: nil, null: false
      t.datetime :updated_at, precision: nil, null: false
      t.string   :email
      t.text     :message
      t.boolean  :approved
      t.integer  :rating

      t.index [:post_id], name: "index_comments_on_post_id"
    end

    remove_column :posts, :commenting_enabled, :boolean, default: false
  end
end
