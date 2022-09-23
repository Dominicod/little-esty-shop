class Merchant::BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = Merchant.find(params[:merchant_id]).bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.new(bulk_discounts_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(merchant), notice: "Bulk Discount created successfully"
    else
      redirect_to new_merchant_bulk_discount_path(merchant), notice: "Bulk Discount not created: Missing required information"
    end
  end

  private
  def bulk_discounts_params
    params.require(:bulk_discount).permit(:percentage, :quantity_threshold)
  end
end
