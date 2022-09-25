class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

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
    if merchant.bulk_discounts.empty?
      return false
    else
      merchant.bulk_discounts.minimum(:quantity_threshold) <= self.quantity
    end
  end
end
