class Admin::CategoriesController < AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_parent_category, only: [:index, :new, :create, :edit]
  before_action :check_invalid_parent_id, only: [:index, :new, :create, :edit]

  # GET /admin/categories
  def index
    @categories = @parent_category.nil? ? Category.roots : @parent_category.children.to_a
  end

  # GET /admin/categories/1
  def show
  end

  # GET /admin/categories/new
  def new
    @category = Category.new
    @category.parent_id = @parent_category.id unless @parent_category.nil?
  end

  # GET /admin/categories/1/edit
  def edit
  end

  # POST /admin/categories
  def create
    @category = Category.new(category_params)

    ActiveRecord::Base.transaction do
      if @category.save
        @category.move_to_child_of(@parent_category) unless @parent_category.nil?
        redirect_to admin_category_url(@category), notice: 'Category was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /admin/categories/1
  def update
    if @category.update(category_params)
      redirect_to admin_category_url(@category), notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/categories/1
  def destroy
    @category.destroy
    redirect_to admin_categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end
    
    def set_parent_category
      @parent_category = Category.find_by_id(params[:parent_id]) if params[:parent_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params[:category].permit(:title, :slug, :parent_id)
    end
    
    def check_invalid_parent_id
      render_404 if !params[:parent_id].nil? && @parent_category.nil?
    end
end
