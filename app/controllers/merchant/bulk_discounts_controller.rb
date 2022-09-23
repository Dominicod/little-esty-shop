class Merchant::BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end
end
