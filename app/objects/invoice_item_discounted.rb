class InvoiceItemDiscounted
  attr_reader :item_id,
              :quantity,
              :unit_price,
              :status,
              :item_name,
              :merchant_id,
              :item,
              :id

  def initialize(invoice_item, merchant_id)
    @item_id = invoice_item.item_id
    @quantity = invoice_item.quantity
    @unit_price = invoice_item.unit_price
    @status = invoice_item.status
    @item_name = invoice_item.item_name
    @item = invoice_item
    @merchant_id = merchant_id
    @id = @item.id
  end

  def applied_discount
    BulkDiscount.max_discount(@item.id, @merchant_id)
  end

  def discounted_price
    self.unit_price - (self.unit_price * applied_discount.percentage.to_f / 100)
  end
end