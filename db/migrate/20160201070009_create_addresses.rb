class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :email, limit: 254, null: false
      t.string :first_name, limit: 100, null: false
      t.string :last_name, limit: 100, null: false
      t.string :country, limit: 50, null: false
      t.string :state, limit: 50
      t.string :city, limit: 100, null: false
      t.string :street_address, limit: 100, null: false
      t.string :zip, limit: 10

      t.timestamps null: false
    end
  end
end
