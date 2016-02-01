class OrdersController < EcommerceController
  before_action :set_order, only: [:show]

  # GET /orders/1
  def show
    render_404 unless my_order?
  end

  # GET /orders/new
  def new
    redirect_to root_url, alert: 'Your order cannot be saved because your basket is empty.' and return if basket.item_count == 0
    
    @order = Order.new
    @order.billing_address = Address.new
    @order.shipping_address = Address.new
    @same_shipping_address = true
  end

  # POST /orders
  def create
    redirect_to root_url, notice: 'Your basket is empty.' and return if order_params[:order_lines].nil? || order_params[:order_lines].count == 0
    
    @same_shipping_address = params[:same_shipping_address]
    begin
      ActiveRecord::Base.transaction do
        @order = Order.new
        @order.date = Time.now
        @order.build_billing_address order_params[:billing_address]
        if @same_shipping_address then
          @order.shipping_address = @order.billing_address
        else
          @order.build_shipping_address order_params[:shipping_address]
        end
        @order.save!
        order_params[:order_lines].each do |index, order_line_params|
          order_line = @order.order_lines.create!(order_line_params)
          product = order_line.product
          product.lock! #this does nothing with SQLite but should really lock with PostgreSQL
          product.quantity -= order_line.quantity
          product.save!
        end
        clear_basket
        remember_my_order
      end
    rescue ActiveRecord::RecordInvalid => e
      if e.record.is_a? Product then
        flash.now[:alert] = "#{e.record.title} has unsufficient stock so the order cannot be saved."
        basket.delete_item e.record.id
        save_basket
      end
      render :new and return
    end

    redirect_to @order, notice: 'Order was successfully created.'
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      address_permitted_params = [:email, :first_name, :last_name, :country, :city, :state, :street_address, :zip]
      order_line_permitted_params = [:product_id, :price, :quantity]
      params.require(:order).permit({billing_address: address_permitted_params, shipping_address: address_permitted_params, order_lines: order_line_permitted_params})
    end
    
    def remebered_order_ids
      order_cookies = cookies[:orders]
      order_cookies.nil? ? [] : order_cookies.split("&").collect{|s| s.to_i}
    end
    
    def remember_my_order
      cookies[:orders] = (remebered_order_ids << @order.id)
    end
    
    def my_order?
      remebered_order_ids.include? @order.id
    end
end
