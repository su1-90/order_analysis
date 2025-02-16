class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :product_code, null: false, limit: 6
      t.string :name, null: false, limit: 255
      t.date :order_date, null: false
      t.integer :order_quantity, null: false

      t.timestamps
    end

    add_index :items, :product_code
  end
end