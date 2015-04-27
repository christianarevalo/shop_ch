class BuyersController < ApplicationController
  respond_to :html

  def index
    @buyers = Buyer.all
    respond_with(@buyers)
  end

end
