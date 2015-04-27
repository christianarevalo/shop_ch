class VariantsController < ProductsController
  before_action :set_product
  before_action :set_variant, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @variants = @product.variants
    respond_with(@variants)
  end

  def show
    respond_with(@variant)
  end

  def new
    @variant = @product.variants.new
  end

  def edit
  end

  def create
    @variant = @product.variants.new(variant_params)
    @variant.save
    respond_with(@product, @variant)
  end

  def update
    @variant.update(variant_params)
    respond_with(@product, @variant)
  end

  def destroy
    @variant.destroy
    respond_with(@product, @variant)
  end

  def buy
    if signed_in?
      @variant = Variant.find(params[:variant_id])

      if @variant.buy(current_buyer)
        flash[:notice] = "Your purchase was successful"
      else
        flash[:alert] = "You don't have enough credits"
      end
    else
      flash[:alert] = 'Please, sign in first.'
    end
    redirect_to :products
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_variant
      @variant = @product.variants.find(params[:id])
    end

    def variant_params
      params.require(:variant).permit(:is_active, :price, :quantity)
    end
end
