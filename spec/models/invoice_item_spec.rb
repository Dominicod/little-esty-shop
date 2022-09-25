require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:invoice_id) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    describe '.for_merchant' do
      it 'can list all of merchant specific items that are on a invoice' do
        @merchant1 = Merchant.create!(id: 45, name:"Bob's Baskets")
        @merchant2 = Merchant.create!(id: 46, name:"Sue's Sandals")

        @customer1 = Customer.create!(id: 45, first_name:"John", last_name:"Doe")

        @item1 = Item.create!(id: 45, name:"Big basket", description:"Green and big", unit_price: 1499, merchant_id: @merchant1.id)
        @item2 = Item.create!(id: 46, name:"Medium basket", description:"Blue and medium", unit_price: 1399, merchant_id: @merchant2.id)

        @invoice1 = Invoice.create!(id: 45, customer_id: @customer1.id, status: 1)

        @invoice_item1 = InvoiceItem.create!(id: 45, item_id: @item1.id, invoice_id: @invoice1.id, quantity:1, unit_price:1499 , status: 0)
        @invoice_item2 = InvoiceItem.create!(id: 46, item_id: @item2.id, invoice_id: @invoice1.id, quantity:2 , unit_price:1399 , status: 1)

        expect(described_class.for_merchant(@merchant1.id).first.item.name).to eq("Big basket")
      end
    end

    describe '.discountable?' do
      it 'Can determine if a invoice_item is discountable based on a merchants bulk discounts' do
        invoice_item = InvoiceItem.find(1)
        expect(invoice_item.discountable?).to eq true

        invoice_item = InvoiceItem.find(5)
        expect(invoice_item.discountable?).to eq false
      end
    end
  end
end
