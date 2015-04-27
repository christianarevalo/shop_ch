require 'test_helper'

class CreatesVariantTest < ActionDispatch::IntegrationTest

  test "can create a variant for a product" do
    @product = products(:product_1)
    get new_product_variant_path(@product)
    assert_response :success
    assert_template "variants/new", partial: "variants/_form"

    post product_variants_path( variant: { is_active: true, price: 10, quantity: 100 }, product_id: @product )
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template "variants/show"
  end
end
