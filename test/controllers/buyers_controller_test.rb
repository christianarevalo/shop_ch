require 'test_helper'

class BuyersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buyers)
  end
end
