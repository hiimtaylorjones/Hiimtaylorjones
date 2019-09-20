class RestructureComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :rating, :integer
    remove_column :comments, :name
  end
end
