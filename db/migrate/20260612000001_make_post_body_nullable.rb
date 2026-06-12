class MakePostBodyNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :posts, :body, true
  end
end
