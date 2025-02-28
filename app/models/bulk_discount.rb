class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  validates :percentage, presence: true
  validates :quantity_threshold, presence: true

  def self.max_discount(invoice_id, merchant_id)
      joins(merchant: [items: :invoice_items])
      .where('invoice_items.id = ? AND merchants.id = ? AND invoice_items.quantity >= quantity_threshold', invoice_id, merchant_id)
      .distinct
      .order(percentage: :desc)
      .limit(1).first
  end
end
