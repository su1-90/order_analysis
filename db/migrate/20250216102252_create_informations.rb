class CreateInformations < ActiveRecord::Migration[7.2]
  def change
    create_table :informations do |t|
      t.string :title, null: false, default: ""
      t.text :message

      t.timestamps
    end
  end
end
