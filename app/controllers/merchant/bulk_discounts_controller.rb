class Merchant::BulkDiscountsController < ApplicationController
  def index
    @merchant = current_merchant
    @bulk_discounts = current_merchant.bulk_discounts
  end

  def show
    @merchant = current_merchant
    @bulk_discount = current_discount
  end

  def new
    @merchant = current_merchant
    @bulk_discount = BulkDiscount.new
  end

  def edit
    @merchant = current_merchant
    @bulk_discount = current_discount
  end

  def update
    if current_discount.update(bulk_discounts_params)
      redirect_to merchant_bulk_discount_path(params[:merchant_id], params[:id]), notice: "Bulk Discount updated successfully"
    else
      redirect_to merchant_bulk_discount_path(params[:merchant_id], params[:id]), notice: "Bulk Discount not updated: Missing required information"
    end
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
    BulkDiscount.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(current_merchant), notice: "Bulk Discount deleted successfully"
  end

  private

  def current_merchant
    Merchant.find(params[:merchant_id])
  end

  def current_discount
    BulkDiscount.find(params[:id])
  end

  def bulk_discounts_params
    params.require(:bulk_discount).permit(:percentage, :quantity_threshold)
  end
end
