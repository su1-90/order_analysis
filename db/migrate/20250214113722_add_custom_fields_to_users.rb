class AddCustomFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :user_code, :string, null: false
    # add_column :users, :password_digest, :string, null: false
    add_column :users, :admin, :boolean, null: false, default: false # カラム名を admin に変更

    add_index :users, :user_code, unique: true
  end
end
