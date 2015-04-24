class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.belongs_to :product
      t.boolean :is_active, null: false, default: true
      t.integer :price, null: false, default: 0
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end
