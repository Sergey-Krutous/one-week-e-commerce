class Admin::ImagesController < AdminController
  before_action :set_image, only: [:destroy]
  before_action :set_product, only: [:index, :new, :create]
  before_action :check_invalid_product_id, only: [:index, :new, :create]

  # GET /product/1/images
  def index
    @images = @product.images
  end

  # GET /product/1/images/new
  def new
    @image = Image.new
  end

  # POST /product/1/images
  def create
    @image = Image.new(image_params)
    @image.product = @product

    if @image.save
      redirect_to admin_images_url(@product), notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  # DELETE /images/1
  def destroy
    @product = @image.product
    @image.destroy
    redirect_to admin_images_url({product_id: @product.id}), notice: 'Image was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params[:image] ? params[:image].permit(:file) : {}
    end
    
    def set_product
      @product = Product.find_by_id(params[:product_id]) if params[:product_id]
    end
    
    def check_invalid_product_id
      render_404 if !params[:product_id].nil? && @product.nil?
    end
end
