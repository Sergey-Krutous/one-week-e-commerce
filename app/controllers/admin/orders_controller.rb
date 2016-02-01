class Admin::OrdersController < AdminController
  before_action :set_order, only: [:show]

  # GET /admin/orders
  def index
    @orders = Order.all
  end

  # GET /admin/orders/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
end
