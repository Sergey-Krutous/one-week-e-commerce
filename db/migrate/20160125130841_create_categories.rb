class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, null:false
      t.references :parent, index: true
      t.integer :lft, :null => false, :index => true, :default => 0
      t.integer :rgt, :null => false, :index => true, :default => 0
      t.integer :depth, :null => false, :default => 0
      t.timestamps null: false
    end
  end
end
