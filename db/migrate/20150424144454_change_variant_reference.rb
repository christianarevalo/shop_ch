class ChangeVariantReference < ActiveRecord::Migration
  def change
    remove_reference :coupons, :variants
    add_reference :coupons, :variant, index: true
  end
end
