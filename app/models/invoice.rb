class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :customer_id, presence: true
  validates :status, presence: true
  enum status: [ :in_progress, :completed, :cancelled]

  def self.not_shipped_invoices
    joins(:invoice_items, :customer).where('invoice_items.status != 2').order(:created_at)
  end

  def total_revenue
    invoice_items.sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def merchant_items(merchant)
    invoice_items = []
    self.invoice_items.each do |invoice_item|
      if invoice_item.owned_by_current_merchant?(merchant)
        invoice_items << invoice_item
      end
    end
    invoice_items
  end

  def total_revenue_by_merchant(merchant)
    merchant_items(merchant).map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.sum
  end
end
