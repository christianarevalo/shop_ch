class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :name, null: false
      t.integer :credits, default: 100

      t.timestamps
    end
  end
end
