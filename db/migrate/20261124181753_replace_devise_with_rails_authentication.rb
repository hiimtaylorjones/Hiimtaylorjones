class ReplaceDeviseWithRailsAuthentication < ActiveRecord::Migration[8.1]
  def change
    # Devise and has_secure_password both store plain bcrypt hashes (no pepper
    # was configured), so existing admin passwords keep working after the rename.
    rename_column :admins, :encrypted_password, :password_digest

    # One row per signed-in browser, looked up from a signed cookie.
    create_table :admin_sessions do |t|
      t.references :admin, null: false, foreign_key: true, type: :integer
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
  end
end
