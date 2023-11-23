class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @time_now = Time.now
    @time_now = @time_now.strftime("%y-%m-%d %H:%M:%S")
  end
end
