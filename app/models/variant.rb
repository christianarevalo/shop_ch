class Variant < ActiveRecord::Base
  belongs_to :product
  has_many :coupons, :dependent => :destroy
end
