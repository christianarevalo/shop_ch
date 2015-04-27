require 'test_helper'

class VariantTest < ActiveSupport::TestCase
  setup do
    @variant_price_10 = variants(:variant_1_2)
    @variant_no_stock = variants(:variant_1_4)
    @variant_not_active = variants(:variant_1_1)
    @buyer_credit_1 = buyers(:david)
    @buyer_credit_1000 = buyers(:michel)
  end

  test "buying without enough credits fails" do
    credits = @buyer_credit_1.credits
    quantity = @variant_price_10.quantity
    assert_not @variant_price_10.buy(@buyer_credit_1)
    assert_equal quantity, @variant_price_10.quantity
    assert_equal credits, @buyer_credit_1.credits
  end

  test "buying with enough credits success" do
    credits = @buyer_credit_1000.credits
    quantity = @variant_price_10.quantity
    assert @variant_price_10.buy(@buyer_credit_1000)
    assert_equal quantity - 1, @variant_price_10.quantity
    assert_equal credits - 10, @buyer_credit_1000.credits
  end

  test "buying with no stock fails" do
    credits = @buyer_credit_1000.credits
    quantity = @variant_no_stock.quantity
    assert_equal 0, quantity
    assert_not @variant_no_stock.buy(@buyer_credit_1000)
    assert_equal quantity, @variant_no_stock.quantity
    assert_equal credits, @buyer_credit_1000.credits
  end

  test "buying inactive fails" do
    credits = @buyer_credit_1000.credits
    quantity = @variant_not_active.quantity
    assert_not @variant_not_active.is_active
    assert_not @variant_not_active.buy(@buyer_credit_1000)
    assert_equal quantity, @variant_not_active.quantity
    assert_equal credits, @buyer_credit_1000.credits
  end
end
