class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :coupons, :dependent => :destroy

  def self.active
    where(is_active: true)
  end

  def self.available
    where("quantity > ?", 0)
  end

  def self.cheapest
    order(:price).first
  end

  def buy(buyer)
    if buyer.credits >= self.price
      transaction do
        buyer.credits -= self.price
        buyer.save!
        self.quantity -= 1
        code =  Array.new(8){[*'0'..'9'].sample}.join
        self.coupons.create(variant_id: id, code: code)
        self.save!
      end
      true
    else
      false
    end
  end
end
