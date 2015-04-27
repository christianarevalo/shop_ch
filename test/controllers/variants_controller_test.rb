require 'test_helper'

class VariantsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @variant = variants(:variant_1_1)
    @product = products(:product_1)
  end

  test "should get index" do
    get :index, product_id: @product
    assert_response :success
    assert_not_nil assigns(:variants)
  end

  test "should get new" do
    get :new, product_id: @product
    assert_response :success
  end

  test "should create variant" do
    assert_difference('Variant.count') do
      post :create, { product_id: @product, variant: { is_active: @variant.is_active, price: @variant.price, quantity: @variant.quantity } }
    end

    assert_redirected_to product_variant_path(assigns(:product), assigns(:variant))
  end

  test "should show variant" do
    get :show, product_id: @product, id: @variant
    assert_response :success
  end

  test "should get edit" do
    get :edit, product_id: @product, id: @variant
    assert_response :success
  end

  test "should update variant" do
    patch :update, { product_id: @product, id: @variant, variant: { is_active: @variant.is_active, price: @variant.price, quantity: @variant.quantity } }
    assert_redirected_to product_variant_path(assigns(:product), assigns(:variant))
  end

  test "should destroy variant" do
    assert_difference('Variant.count', -1) do
      delete :destroy, product_id: @product, id: @variant
    end

    assert_redirected_to product_variants_path
  end
end
