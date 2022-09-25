require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:status) }
  end

  describe '.not_shipped_invoices' do
    it "Should return invoice id's in creation order" do
      invoice_ids = [5, 5, 7, 3, 3, 3, 3, 3, 2, 2, 2, 4, 4, 1, 1, 1, 1, 1]

      expect(Invoice.not_shipped_invoices.ids).to eq invoice_ids
      expect(Invoice.not_shipped_invoices.ids.count).to eq 18
    end
  end

  describe '.total_revenue' do
    it "Should return the total price of all items on an invoice" do
      expect(Invoice.first.total_revenue).to eq(2106777)
    end
  end

  describe '.merchant_items' do
    it 'Should return the invoice_items that the merchant owns' do
      invoice = Invoice.find(3)
      merchant = Merchant.find(2)
      merchant_items = invoice.merchant_items(merchant)

      expect(merchant_items.count).to eq 3
      expect(merchant_items[0].item).to eq InvoiceItem.find(17)
      expect(merchant_items[1].item).to eq InvoiceItem.find(19)
      expect(merchant_items[2].item).to eq InvoiceItem.find(20)
    end
  end

  describe '.total_revenue_by_merchant' do
    it 'Should return total revenue of the merchant' do
      invoice = Invoice.find(3)
      merchant = Merchant.find(2)

      expect(invoice.total_revenue_by_merchant(merchant)).to eq 1269821
    end
  end
end
