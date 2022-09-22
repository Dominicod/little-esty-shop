require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before(:each) { mock_api_call }

  describe 'As a merchant' do
    describe 'When I visit my merchant items index page ("merchants/merchant_id/items")' do
      it 'I see a list of the names of all of my items' do
        visit merchant_items_path(Merchant.first)

          expect(page).to have_content("Item Qui Esse")
          expect(page).to have_content("Item Autem Minima")
          expect(page).to have_content("Item Ea Voluptatum")
      end

      it 'I do not see items for any other merchant' do
        visit merchant_items_path(Merchant.first)

          expect(page).to_not have_content("Item Nemo Facere")
          expect(page).to_not have_content("Item Expedita Aliquam")
          expect(page).to_not have_content("Item Provident At")
          expect(page).to_not have_content("Item Itaque Consequatur")
      end

      it 'next to each item I see a button to disable or enable that item' do
        item = Item.find_by(name: "Item Qui Esse")

          expect(item.status).to eq("disabled")

        visit merchant_items_path(Merchant.first)

          expect(page).to have_content("Item Qui Esse")
          find("div#1").click_button("enable")

          expect(current_path).to eq(merchant_items_path(Merchant.first))
          expect(item.reload.status).to eq("enabled")
          expect(page).to have_button("disable")
      end

      it 'has two sections, one for "Enabled Items"  and one for "Disabled Items"' do
        visit merchant_items_path(Merchant.first)

          expect(page).to have_content("Enabled Items")
          expect(page).to have_content("Disabled Items")

        within "div#Disabled_Items" do
          expect(page).to have_content("Autem Minima")
          expect(page).to have_content("Ea Voluptatum")
          expect(page).to have_content("Item Qui Esse")
        end

        find("div#1").click_button("enable")

        within "div#Enabled_Items" do
          expect(page).to have_content("Item Qui Esse")
          expect(page).to_not have_content("Ea Voluptatum")
          expect(page).to_not have_content("Autem Minima")
        end

        within "div#Disabled_Items" do
          expect(page).to have_content("Autem Minima")
          expect(page).to have_content("Ea Voluptatum")
          expect(page).to_not have_content("Item Qui Esse")
        end
      end

      describe '5 most popular items' do
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

          @invoice1 = Invoice.create!(id: 45, customer_id: @customer1.id, status: 1, created_at: "2012-04-21 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice2 = Invoice.create!(id: 46, customer_id: @customer2.id, status: 1, created_at: "2012-04-22 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice3 = Invoice.create!(id: 47, customer_id: @customer2.id, status: 0, created_at: "2012-04-23 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice4 = Invoice.create!(id: 48, customer_id: @customer2.id, status: 2, created_at: "2012-04-24 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice5 = Invoice.create!(id: 49, customer_id: @customer3.id, status: 1, created_at: "2012-04-25 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice6 = Invoice.create!(id: 50, customer_id: @customer3.id, status: 0, created_at: "2012-04-26 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice7 = Invoice.create!(id: 51, customer_id: @customer3.id, status: 1, created_at: "2012-04-27 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice8 = Invoice.create!(id: 52, customer_id: @customer3.id, status: 2, created_at: "2012-04-28 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice9 = Invoice.create!(id: 53, customer_id: @customer3.id, status: 2, created_at: "2012-04-29 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice10 = Invoice.create!(id: 54, customer_id: @customer4.id, status: 1, created_at: "2012-04-21 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice11 = Invoice.create!(id: 55, customer_id: @customer4.id, status: 1, created_at: "2012-04-22 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice12 = Invoice.create!(id: 56, customer_id: @customer4.id, status: 1, created_at: "2012-04-23 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice13 = Invoice.create!(id: 57, customer_id: @customer4.id, status: 0, created_at: "2012-04-24 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice14 = Invoice.create!(id: 58, customer_id: @customer5.id, status: 1, created_at: "2012-04-25 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice15 = Invoice.create!(id: 59, customer_id: @customer5.id, status: 1, created_at: "2012-04-26 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice16 = Invoice.create!(id: 60, customer_id: @customer5.id, status: 0, created_at: "2012-04-27 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice17 = Invoice.create!(id: 61, customer_id: @customer5.id, status: 0, created_at: "2012-04-28 14:54:09 UTC,2012-03-27 14:54:09 UTC")
          @invoice18 = Invoice.create!(id: 62, customer_id: @customer5.id, status: 1, created_at: "2012-04-29 14:54:09 UTC,2012-03-27 14:54:09 UTC")

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

        it 'I see the names of the top 5 most popular items ranked by total revenue generated' do
          visit merchant_items_path(45)

          within '#most_popular_items' do
            item1 = @item1.name
            item2 = @item2.name
            item3 = @item3.name

            expect(item2).to appear_before(item3)
            expect(item3).to appear_before(item1)
          end
        end

        it 'I see that each item name links to my merchant items show page for that item' do
          visit merchant_items_path(45)

          within '#most_popular_items' do
            expect(page).to have_link("Medium basket")
            click_link ("Medium basket")
            expect(current_path).to eq(merchant_item_path(@merchant1, @item2))

            visit merchant_items_path(45)
            expect(page).to have_link("Little basket")
            click_link ("Little basket")
            expect(current_path).to eq(merchant_item_path(@merchant1, @item3))

            visit merchant_items_path(45)
            expect(page).to have_link("Big basket")
            click_link ("Big basket")
            expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
          end
        end

        it 'I see the total revenue generated next to each item name' do
          visit merchant_items_path(45)

          within "#most_popular_items" do
            expect(page).to have_content("Medium basket - $391.72 in sales")
            expect(page).to have_content("Little basket - $311.74 in sales")
            expect(page).to have_content("Big basket - $164.89 in sales")
          end
        end

        it 'Next to each of the 5 most popular items I see the date with the most sales for each item' do
          visit merchant_items_path(45)

          within "#most_popular_items" do
            within "#item_46" do
              expect(page).to have_content("4/22/2012")
            end

            within "#item_47" do
              expect(page).to have_content("4/25/2012")
            end

            within "#item_45" do
              expect(page).to have_content("4/21/2012")
            end
          end
        end

        it 'I see a label "Top selling date for ___ was ___"' do
          visit merchant_items_path(45)

          within "#most_popular_items" do
            within "#item_46" do
              expect(page).to have_content("Top selling date for Medium basket was 4/22/2012")
            end

            within "#item_47" do
              expect(page).to have_content("Top selling date for Little basket was 4/25/2012")
            end

            within "#item_45" do
              expect(page).to have_content("Top selling date for Big basket was 4/21/2012")
            end
          end
        end
      end
    end
  end
end
