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
      expect(merchant_items[0].item).to eq Item.find(14)
      expect(merchant_items[1].item).to eq Item.find(5)
      expect(merchant_items[2].item).to eq Item.find(4)
    end
  end

  describe '.total_revenue_by_merchant' do
    it 'Should return total revenue of the merchant' do
      invoice_1 = Invoice.find(3)
      merchant_1 = Merchant.find(2)
      invoice_2 = Invoice.find(1)
      merchant_2 = Merchant.find(2)

      expect(invoice_1.total_revenue_by_merchant(merchant_1)).to eq 1269821
      expect(invoice_2.total_revenue_by_merchant(merchant_2)).to eq 1282714
    end
  end

  describe '.discounted_revenue_by_merchant' do
    it 'Should return total discounted revenue of the merchant' do
      invoice_1 = Invoice.find(3)
      merchant_1 = Merchant.find(2)
      invoice_2 = Invoice.find(1)
      merchant_2= Merchant.find(2)

      expect(invoice_1.discounted_revenue_by_merchant(merchant_1)).to eq 1269821
      expect(invoice_2.discounted_revenue_by_merchant(merchant_2)).to eq 1027484
    end
  end

  describe '.total_discounted_revenue' do
    it 'Should return total discounted revenue based on the entire invoice' do
      invoice_1 = Invoice.find(1)
      invoice_2 = Invoice.find(2)

      expect(invoice_1.total_discounted_revenue).to eq 1833201
      expect(invoice_2.total_discounted_revenue).to eq 187274
    end
  end
end
