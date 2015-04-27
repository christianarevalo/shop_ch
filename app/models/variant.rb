class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :coupons, :dependent => :destroy

  validates_presence_of :product, :is_active, :quantity, :price

  def self.active
    where(is_active: true)
  end

  def self.available
    where("quantity > ?", 0)
  end

  def self.cheapest
    order(:price)
  end

  def self.available_products
    available.active.cheapest.group(:product_id).includes(:product)
  end

  def buy(buyer)
    if buyer.credits >= self.price && self.quantity > 0 && self.is_active
      transaction do
        buyer.credits -= self.price
        buyer.save!
        self.quantity -= 1
        self.coupons.create(variant_id: id)
        self.save!
      end
      true
    else
      false
    end
  end
end
