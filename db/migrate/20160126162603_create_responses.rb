class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.belongs_to :comment
      t.text :message
      t.timestamps null: false
    end
  end
end
