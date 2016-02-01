class BasketItemsController < EcommerceController
  # POST /basket/items.js
  def create
    product = Product.find_by_id(params[:product_id])
    @error_message = basket.add_item(product.id, 1, product.price).error_message if product
    save_basket
    respond_to do |format|
      format.js { render :show }
      format.html { redirect_to URI(request.referer).path }
    end
  end

  # DELETE /basket/items/1.js
  def destroy
    basket.delete_item params[:product_id]
    save_basket
    respond_to do |format|
      format.js { render :show }
    end
  end
end
