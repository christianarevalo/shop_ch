class Coupon < ActiveRecord::Base
  belongs_to :variant
  before_validation :generate_code, on: :create

  validates_presence_of :variant, :code


  protected

  def generate_code
    self.code = Array.new(8){[*'0'..'9'].sample}.join
  end
end
