class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :check_invalid_product_id, only: [:show]
  before_action :set_category, only: [:index]
  before_action :check_invalid_category_id, only: [:index]

  # GET /products
  def index
    if params[:slug] then
      params[:slug] = "/" + params[:slug] unless params[:slug].start_with?("/")
      @product = Product.find_by_slug(params[:slug])
      if @product then
        render :show and return if @product.quantity > 0
        render_404 and return
      end
      @category = Category.find_by_slug(params[:slug])
    end
    if @category then
      @products = Array.new
      @category.self_and_descendants.includes(:products).each { |category| @products << category.products.where("quantity > 0") }
      @products = @products.flatten.uniq
    elsif params[:slug]
      #invalid slug - no product and no category
      render_404 and return
    else
      @products = Product.all.where("quantity > 0")
    end
  end

  # GET /products/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      @product = nil if @product and @product.quantity == 0
    end
    
    def set_category
      @category = Category.find_by_id(params[:category_id])
    end
    
    def check_invalid_category_id
      render_404 if !params[:category_id].nil? && @category.nil?
    end
    
    def check_invalid_product_id
      render_404 if @product.nil?
    end
end
