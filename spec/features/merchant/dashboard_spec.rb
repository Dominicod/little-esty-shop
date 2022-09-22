require 'rails_helper'

RSpec.describe "merchant dashboard" do
  before :each do
    mock_api_call

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
    @invoice16 = Invoice.create!(id: 60, customer_id: @customer5.id, status: 0, created_at:"2022-09-19 09:54:09" )
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

  describe 'As a merchant, When I visit my merchant dashboard' do
    it 'I see the name of my merchant' do
      visit merchant_dashboard_index_path(Merchant.first)

      expect(page).to have_content(Merchant.first.name)
      expect(page).to_not have_content(Merchant.last.name)
    end

    it 'I see link to my merchant items index' do
      visit merchant_dashboard_index_path(Merchant.first)

      expect(page).to have_link("My Items")
    end

    it 'I see link to my merchant invoices index' do
      visit merchant_dashboard_index_path(Merchant.first)

      expect(page).to have_link("My Invoices")
    end

    describe 'Top 5 Customers' do

      it 'I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant' do
        visit merchant_dashboard_index_path(45)

        within ("#top_customers") do
          customer1 = "Porter Whitehall"
          customer2 = "Donna Petereit"
          customer3 = "Carla Whipkey"
          customer4 = "Becka Hendricks"
          customer5 = "John Doe"

          expect(customer1).to appear_before(customer2)
          expect(customer2).to appear_before(customer3)
          expect(customer3).to appear_before(customer4)
          expect(customer4).to appear_before(customer5)
        end
      end

      it 'Next to each customer name I see the number of successful transactions they have conducted with my merchant' do
        visit merchant_dashboard_index_path(45)

        within "#customer_49" do
          expect(page).to have_content("Porter Whitehall - 5 purchases")
        end

        within "#customer_48" do
          expect(page).to have_content("Donna Petereit - 4 purchases")
        end

        within "#customer_47" do
          expect(page).to have_content("Carla Whipkey - 3 purchases")
        end

        within "#customer_46" do
          expect(page).to have_content("Becka Hendricks - 2 purchases")
        end

        within "#customer_45" do
          expect(page).to have_content("John Doe - 1 purchases")
        end
      end
    end

    describe 'Items Ready to Ship' do
      it 'In that section I see a list of the names of all of my items that have been ordered and have not yet been shipped' do
        visit merchant_dashboard_index_path(45)

        within '#items_ready_to_ship' do
          expect(page).to have_content("Items Ready to Ship")
          expect(page).to have_content(@item2.name)
          expect(page).to have_content(@item3.name)
        end
      end

      it 'Next to each item, I see the id of the invoice that ordered my item' do
        visit merchant_dashboard_index_path(45)

        within "#item_47" do
          expect(page).to have_content("Invoice #60")
        end
      end

      it 'Each invoice id is a link to my merchants invoice show page' do
        visit merchant_dashboard_index_path(45)

        within "#item_47" do
          expect(page).to have_link("Invoice #60")
          click_link ("Invoice #60")
          expect(current_path).to eq(merchant_invoice_path(@merchant1, @invoice16))
        end
      end

      it 'Next to each item name, I see the date that the invoice was created. I see the date formatted like "Monday, July 18, 2019"' do
        visit merchant_dashboard_index_path(45)

        within "#item_47" do
          expect(page).to have_content("Little basket - Invoice #60 - Monday, September 19, 2022")
        end
      end

      it 'I see that the list is ordered from oldest to newest' do
        visit merchant_dashboard_index_path(45)

        item1 = "Medium basket"
        item2 = "Little basket"

        within '#items_ready_to_ship' do
          expect(item2).to appear_before(item1)
        end
      end
    end
  end
end
