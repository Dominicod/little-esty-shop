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

  def total_discounted_revenue
    unit_revenue = invoice_items.where("bulk_discount_id IS NULL").sum('invoice_items.quantity * invoice_items.unit_price')
    discount_revenue = invoice_items.where("bulk_discount_id != 0").sum('invoice_items.quantity * invoice_items.discounted_unit_price')
    unit_revenue + discount_revenue
  end

  def merchant_items(merchant)
    invoice_items.joins(:item).where('items.merchant_id = ?', merchant.id)
  end

  def total_revenue_by_merchant(merchant)
    merchant_items(merchant).sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def discounted_revenue_by_merchant(merchant)
    unit_revenue = self.merchant_items(merchant).where("bulk_discount_id IS NULL").sum('invoice_items.quantity * invoice_items.unit_price')
    discount_revenue = self.merchant_items(merchant).where("bulk_discount_id != 0").sum('invoice_items.quantity * invoice_items.discounted_unit_price')
    unit_revenue + discount_revenue
  end
end
