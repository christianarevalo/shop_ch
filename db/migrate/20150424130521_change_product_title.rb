class ChangeProductTitle < ActiveRecord::Migration
  def change
    Product.update_all({:title => 'Default Title'})
    change_column :products, :title, :string, :null => false
  end
end
