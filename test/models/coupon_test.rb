require 'test_helper'

class CouponTest < ActiveSupport::TestCase
  setup do
    @variant = variants(:variant_1_2)
    @poor = buyers(:david)
    @rich= buyers(:michel)
  end

  test "buy success creates coupon" do
    coupons = @variant.coupons.count
    assert @variant.buy(@rich)
    assert_equal coupons + 1, @variant.coupons.count
  end

  test "buy fails does not creates coupon" do
    coupons = @variant.coupons.count
    assert_not @variant.buy(@poor)
    assert_equal coupons, @variant.coupons.count
  end
end
