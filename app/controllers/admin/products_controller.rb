class Admin::ProductsController < AdminController 
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    ActiveRecord::Base.transaction do
      if @product.save
        set_product_categories
        redirect_to admin_product_url(@product) , notice: 'Product was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    ActiveRecord::Base.transaction do
      if @product.update(product_params)
        set_product_categories
        redirect_to admin_product_url(@product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to admin_products_url, notice: 'Product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params[:product].permit(:title, :slug, :description, :price, :quantity, :category_ids)
    end
    
    def set_product_categories
      @product.categories.clear
      params[:product][:category_ids].each { |category_id| @product.categories << Category.find_by_id(category_id) } if params[:product] and params[:product][:category_ids]
    end
end
