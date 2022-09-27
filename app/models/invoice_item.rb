class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  belongs_to :bulk_discount, optional: true

  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true
  enum status: [ :pending, :packaged, :shipped]

  def self.for_merchant(merchant_id)
    select("invoice_items.item_id, invoice_items.status, invoice_items.unit_price, invoice_items.quantity")
      .joins(item: [:invoice_items])
      .where("items.merchant_id = #{merchant_id}")
  end

  def discountable?
    merchant = self.item.merchant
    merchant.bulk_discounts.empty? ? false : merchant.bulk_discounts.minimum(:quantity_threshold) <= self.quantity
  end

  def discount(discount)
    percentage = (discount.percentage.to_f / 100)
    (unit_price - ((unit_price * percentage) / 100) * 100).to_i
  end
end
