class ChangeCommentsStructure < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :commenter, :string
    remove_column :comments, :body, :string

    add_column :comments, :name, :string
    add_column :comments, :email, :string
    add_column :comments, :message, :text
    add_column :comments, :approved, :boolean
  end
end
