class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, limit: 100
      t.string :slug, limit: 100
      t.string :description, limit: 500
      t.decimal :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
