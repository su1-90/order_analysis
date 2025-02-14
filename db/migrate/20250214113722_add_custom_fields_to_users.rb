class AddCustomFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_code, :integer, null: false, limit: 6
    add_column :users, :password_digest, :string, null: false
    add_column :users, :is_admin, :boolean, null: false, default: false

    add_index :users, :user_code, unique: true
  end
end
