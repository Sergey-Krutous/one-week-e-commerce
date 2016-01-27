class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :product, index: true, null: false
      t.string :file, null: false
      
      t.timestamps null: false
    end
  end
end
