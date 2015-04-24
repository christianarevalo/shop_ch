class Coupon < ActiveRecord::Base
  belongs_to :variant
  before_validation :generate_code, on: :create


  protected

  def generate_code
    code = Array.new(8){[*'0'..'9'].sample}.join
  end
end
