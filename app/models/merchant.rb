class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def enabled_items
    items.where(status: "enabled")
  end

  def disabled_items
    items.where(status: "disabled")
  end

  def self.enabled_merchants
    where(status: "enabled")
  end

  def self.disabled_merchants
    where(status: "disabled")
  end

  def self.top_five_by_revenue
    joins(:items, invoices: :transactions)
      .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
      .group(:id)
      .where(transactions: {result: 0})
      .order(revenue: :desc)
      .limit(5)
  end
end
