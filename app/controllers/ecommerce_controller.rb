class EcommerceController < ApplicationController
  helper_method :basket

protected

  def basket
    @basket ||= Basket.new(session[:basket]) #session serializes basket into Hash - we need deserialization here
  end

  def save_basket
    session[:basket] = @basket.serialize
  end
  
  def clear_basket
    session.delete :basket
    @basket = nil
  end
end