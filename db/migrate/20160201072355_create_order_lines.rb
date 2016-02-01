class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.references :order, order: true, index: true, foreign_key: true, null: false
      t.references :product, product: true, index: true, foreign_key: true, null: false
      t.decimal :price, null: false
      t.integer :quantity, null: false

      t.timestamps null: false
    end
  end
end
