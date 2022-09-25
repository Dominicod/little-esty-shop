class Merchant::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.all.uniq
  end

  def show
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_items = merchant_items
    @total_revenue = total_revenue_by_merchant
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(invoice_item_params)
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end

  private
  def owned_by_current_merchant?(invoice_item, merchant)
    invoice_item.item.merchant == merchant
  end

  def merchant_items
    invoice_items = []
    @invoice.invoice_items.map do |invoice_item|
      if owned_by_current_merchant?(invoice_item, @merchant)
        if invoice_item.discountable?
          BulkDiscount.max_discount(invoice_item.id, @merchant.id)
          invoice_items << invoice_item
        else
          invoice_items << invoice_item
        end
      end
    end
    invoice_items
  end

  def total_revenue_by_merchant
    @invoice_items.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.sum
  end

  def invoice_item_params
    params.permit(:invoice_id, :item_id, :quantity, :unit_price, :status)
  end
end
