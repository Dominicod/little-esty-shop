class Merchant::BulkDiscountsController < ApplicationController
  def index
    @merchant = current_merchant
    @bulk_discounts = current_merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = current_merchant
    @bulk_discount = BulkDiscount.new
  end

  def create
    bulk_discount = current_merchant.bulk_discounts.new(bulk_discounts_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(current_merchant), notice: "Bulk Discount created successfully"
    else
      redirect_to new_merchant_bulk_discount_path(current_merchant), notice: "Bulk Discount not created: Missing required information"
    end
  end

  def destroy
    if BulkDiscount.destroy(params[:id])
      redirect_to merchant_bulk_discounts_path(current_merchant), notice: "Bulk Discount deleted successfully"
    else
      redirect_to merchant_bulk_discounts_path(current_merchant), notice: "Bulk Discount not deleted: Fatal Error"
    end
  end

  private

  def current_merchant
    Merchant.find(params[:merchant_id])
  end

  def bulk_discounts_params
    params.require(:bulk_discount).permit(:percentage, :quantity_threshold)
  end
end
