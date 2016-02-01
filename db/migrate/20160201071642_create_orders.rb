class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :date, null: false
      t.references :billing_address, address: true, index: true, foreign_key: true, null: false
      t.references :shipping_address, address: true, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
