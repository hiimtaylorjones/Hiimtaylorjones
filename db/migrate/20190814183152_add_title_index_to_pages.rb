class AddTitleIndexToPages < ActiveRecord::Migration[5.2]
  def change
    add_index :pages, :title, unique: true
  end
end
