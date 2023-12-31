class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :concept, null: false
      t.integer :price, null: false
      t.integer :category_id, null: false
      t.integer :situation_id, null: false
      t.integer :shipping_charge_id, null: false
      t.integer :shipping_area_id, null: false
      t.integer :shipping_date_id, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
