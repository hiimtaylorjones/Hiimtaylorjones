class AddNavbarOptionsToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :navbar_visibility, :string, default: "visible"
    add_column :pages, :navbar_position, :integer
  end
end
