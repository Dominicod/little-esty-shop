require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through (:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'class methods' do
    before :each do
      @merchant1 = Merchant.create!(id: 45, name:"Bob's Baskets")

      @customer1 = Customer.create!(id: 45, first_name:"John", last_name:"Doe")
      @customer2 = Customer.create!(id: 46, first_name:"Becka", last_name:"Hendricks")
      @customer3 = Customer.create!(id: 47, first_name:"Carla", last_name:"Whipkey")
      @customer4 = Customer.create!(id: 48, first_name:"Donna", last_name:"Petereit")
      @customer5 = Customer.create!(id: 49, first_name:"Porter", last_name:"Whitehall")
      @customer6 = Customer.create!(id: 50, first_name:"Corey", last_name:"Whitehall")

      @item1 = Item.create!(id: 45, name:"Big basket", description:"Green and big", unit_price: 1499, merchant_id: @merchant1.id)
      @item2 = Item.create!(id: 46, name:"Medium basket", description:"Blue and medium", unit_price: 1399, merchant_id: @merchant1.id)
      @item3 = Item.create!(id: 47, name:"Little basket", description:"Yellow and small", unit_price: 1199, merchant_id: @merchant1.id)

      @invoice1 = Invoice.create!(id: 45, customer_id: @customer1.id, status: 1)
      @invoice2 = Invoice.create!(id: 46, customer_id: @customer2.id, status: 1)
      @invoice3 = Invoice.create!(id: 47, customer_id: @customer2.id, status: 0)
      @invoice4 = Invoice.create!(id: 48, customer_id: @customer2.id, status: 2)
      @invoice5 = Invoice.create!(id: 49, customer_id: @customer3.id, status: 1)
      @invoice6 = Invoice.create!(id: 50, customer_id: @customer3.id, status: 0)
      @invoice7 = Invoice.create!(id: 51, customer_id: @customer3.id, status: 1)
      @invoice8 = Invoice.create!(id: 52, customer_id: @customer3.id, status: 2)
      @invoice9 = Invoice.create!(id: 53, customer_id: @customer3.id, status: 2)
      @invoice10 = Invoice.create!(id: 54, customer_id: @customer4.id, status: 1)
      @invoice11 = Invoice.create!(id: 55, customer_id: @customer4.id, status: 1)
      @invoice12 = Invoice.create!(id: 56, customer_id: @customer4.id, status: 1)
      @invoice13 = Invoice.create!(id: 57, customer_id: @customer4.id, status: 0)
      @invoice14 = Invoice.create!(id: 58, customer_id: @customer5.id, status: 1)
      @invoice15 = Invoice.create!(id: 59, customer_id: @customer5.id, status: 1)
      @invoice16 = Invoice.create!(id: 60, customer_id: @customer5.id, status: 0)
      @invoice17 = Invoice.create!(id: 61, customer_id: @customer5.id, status: 0)
      @invoice18 = Invoice.create!(id: 62, customer_id: @customer5.id, status: 1)

      @invoice_item1 = InvoiceItem.create!(id: 45, item_id: @item1.id, invoice_id: @invoice1.id, quantity:1, unit_price:1499 , status: 0)
      @invoice_item2 = InvoiceItem.create!(id: 46, item_id: @item2.id, invoice_id: @invoice2.id, quantity:2 , unit_price:1399 , status: 1)
      @invoice_item3 = InvoiceItem.create!(id: 47, item_id: @item1.id, invoice_id: @invoice3.id, quantity:3 , unit_price:1499 , status: 2)
      @invoice_item4 = InvoiceItem.create!(id: 48, item_id: @item3.id, invoice_id: @invoice4.id, quantity:4 , unit_price:1199 , status: 0)
      @invoice_item5 = InvoiceItem.create!(id: 49, item_id: @item1.id, invoice_id: @invoice5.id, quantity:5 , unit_price:1499 , status: 1)
      @invoice_item6 = InvoiceItem.create!(id: 50, item_id: @item2.id, invoice_id: @invoice6.id, quantity:6 , unit_price:1399 , status: 2)
      @invoice_item7 = InvoiceItem.create!(id: 51, item_id: @item2.id, invoice_id: @invoice7.id, quantity:5 , unit_price:1399 , status: 0)
      @invoice_item8 = InvoiceItem.create!(id: 52, item_id: @item3.id, invoice_id: @invoice8.id, quantity:4 , unit_price:1199 , status: 1)
      @invoice_item9 = InvoiceItem.create!(id: 53, item_id: @item3.id, invoice_id: @invoice9.id, quantity:3 , unit_price:1199 , status: 0)
      @invoice_item10 = InvoiceItem.create!(id: 54, item_id: @item1.id, invoice_id: @invoice10.id, quantity:2 , unit_price:1499 , status: 0)
      @invoice_item11 = InvoiceItem.create!(id: 55, item_id: @item2.id, invoice_id: @invoice11.id, quantity:1 , unit_price:1399 , status: 1)
      @invoice_item12 = InvoiceItem.create!(id: 56, item_id: @item2.id, invoice_id: @invoice12.id, quantity:2 , unit_price:1399 , status: 2)
      @invoice_item13 = InvoiceItem.create!(id: 57, item_id: @item2.id, invoice_id: @invoice13.id, quantity:3 , unit_price:1399 , status: 0)
      @invoice_item14 = InvoiceItem.create!(id: 58, item_id: @item3.id, invoice_id: @invoice14.id, quantity:4 , unit_price:1199 , status: 1)
      @invoice_item15 = InvoiceItem.create!(id: 59, item_id: @item3.id, invoice_id: @invoice15.id, quantity:5 , unit_price:1199 , status: 2)
      @invoice_item16 = InvoiceItem.create!(id: 60, item_id: @item3.id, invoice_id: @invoice16.id, quantity:6 , unit_price:1199 , status: 0)
      @invoice_item17 = InvoiceItem.create!(id: 61, item_id: @item2.id, invoice_id: @invoice17.id, quantity:5 , unit_price:1399 , status: 1)
      @invoice_item18 = InvoiceItem.create!(id: 62, item_id: @item2.id, invoice_id: @invoice18.id, quantity:4, unit_price:1399 , status: 2)

      @transaction1 = Transaction.create!(id: 45, invoice_id: @invoice1.id, credit_card_number:1 , result:0)
      @transaction2 = Transaction.create!(id: 46, invoice_id: @invoice2.id, credit_card_number:2 , result:0)
      @transaction3 = Transaction.create!(id: 47, invoice_id: @invoice3.id, credit_card_number:3 , result:0)
      @transaction4 = Transaction.create!(id: 48, invoice_id: @invoice4.id, credit_card_number:4 , result:1)
      @transaction5 = Transaction.create!(id: 49, invoice_id: @invoice5.id, credit_card_number:5 , result:0)
      @transaction6 = Transaction.create!(id: 50, invoice_id: @invoice6.id, credit_card_number:6 , result:0)
      @transaction7 = Transaction.create!(id: 51, invoice_id: @invoice7.id, credit_card_number:7 , result:0)
      @transaction8 = Transaction.create!(id: 52, invoice_id: @invoice8.id, credit_card_number:8 , result:1)
      @transaction9 = Transaction.create!(id: 53, invoice_id: @invoice9.id, credit_card_number:9 , result:1)
      @transaction10 = Transaction.create!(id: 54, invoice_id: @invoice10.id, credit_card_number:10 , result:0)
      @transaction11 = Transaction.create!(id: 55, invoice_id: @invoice11.id, credit_card_number:11 , result:0)
      @transaction12 = Transaction.create!(id: 56, invoice_id: @invoice12.id, credit_card_number:12 , result:0)
      @transaction13 = Transaction.create!(id: 57, invoice_id: @invoice13.id, credit_card_number:13 , result:0)
      @transaction14 = Transaction.create!(id: 58, invoice_id: @invoice14.id, credit_card_number:14 , result:0)
      @transaction15 = Transaction.create!(id: 59, invoice_id: @invoice15.id, credit_card_number:15 , result:0)
      @transaction16 = Transaction.create!(id: 60, invoice_id: @invoice16.id, credit_card_number:16 , result:0)
      @transaction17 = Transaction.create!(id: 61, invoice_id: @invoice17.id, credit_card_number:17 , result:0)
      @transaction18 = Transaction.create!(id: 62, invoice_id: @invoice18.id, credit_card_number:18 , result:0)
    end

    describe '.ready_to_ship' do
      it 'can list all of a merchant items that are ready to ship' do
        expect(Item.ready_to_ship(45)).to eq([@item2, @item3, @item2])
      end
    end

    describe '.order_by_revenue' do
      it 'can list items in order from most revenue to least' do
        expect(@merchant1.items.order_by_revenue).to eq([@item2, @item3, @item1])
      end
    end
  end

  describe 'instance methods' do
    it 'can determine the date with the most sales of an item' do
      expect(Item.first.best_day).to eq("Sun, 25 Mar 2012 09:54:09 UTC +00:00")
    end
  end
end
