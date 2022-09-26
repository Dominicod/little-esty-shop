require 'rails_helper'

RSpec.describe 'Merchant Invoices Show Page' do
  let(:merchant) { Merchant.first }
  let(:merchant_2) { Merchant.find(2) }
  let(:invoice_1) { merchant.invoices.first }
  before(:each) { mock_api_call }

  describe 'As a merchant' do
    describe 'When I visit my merchant invoices show page' do
      it 'Then I see information related to that invoice' do
        visit merchant_invoice_path(merchant, invoice_1)

          expect(page).to have_content("Invoice ID: 1")
          expect(page).to have_content("Invoice Status: cancelled")
          expect(page).to have_content("Invoice Date: Sunday, March 25, 2012")
          expect(page).to have_content("Invoice Customer Name: Joey Ondricka")
          expect(page).to_not have_content("Invoice ID: 5")
      end

      it 'I see all of my items on the invoice including the name' do
        visit merchant_invoice_path(merchant, invoice_1)

        within "div#1" do
          expect(page).to have_content("Item Name: Item Qui Esse")
          expect(page).to have_content("Item Quantity: 5")
          expect(page).to have_content("Item Unit Price: $136.35")

          expect(page).to_not have_content("Item Name: Item Expedita Aliquam")
          expect(page).to_not have_content("Item Name: Provident At")
        end
      end

      it 'I see the total revenue that will be generated from all of my items on the invoice' do
        visit merchant_invoice_path(merchant, invoice_1)
          expect(page).to have_content("Total Revenue: $8240.63")
      end

      it 'I see that each invoice item status is a select field and I see that the invoice items current status is selected' do
        visit merchant_invoice_path(merchant, invoice_1)

        within "div#1" do
          within "#status_#{invoice_1.invoice_items.first.id}" do
            expect(page).to have_select('status'), 'packaged'
          end
        end
      end

      describe 'When I click this select field' do
        it 'I can select a new status for the Item' do
          visit merchant_invoice_path(merchant, invoice_1)

          within "div#1" do
            within "#status_#{invoice_1.invoice_items.first.id}" do
              select :shipped, from: 'status'

              expect(page).to have_select('status'), 'shipped'
            end
          end
        end

        it 'next to the select field I see a button to "Update Item Status"' do
          visit merchant_invoice_path(merchant, invoice_1)

          within "div#1" do
            within "#status_#{invoice_1.invoice_items.first.id}" do
              expect(page).to have_button('Update Item Status')
            end
          end
        end

        describe 'When I click this button' do
          it 'I am taken back to the merchant invoice show page' do
            visit merchant_invoice_path(merchant, invoice_1)

            within "div#1" do
              within "#status_#{invoice_1.invoice_items.first.id}" do
                select :shipped, from: 'status'
                click_button 'Update Item Status'
                expect(current_path).to eq(merchant_invoice_path(merchant, invoice_1))
              end
            end
          end

          it 'I see that my Items status has now been updated' do
            visit merchant_invoice_path(merchant, invoice_1)

            within "div#1" do
              within "#status_#{invoice_1.invoice_items.first.id}" do
                select :shipped, from: 'status'
                click_button 'Update Item Status'
                expect(page).to have_select('status'), 'shipped'
              end
            end
          end

          it 'I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation' do
            visit merchant_invoice_path(merchant, invoice_1)

            within("#discounted_total_revenue") do
              expect(page).to have_content("$2838.04")
            end
          end

          it 'Next to each invoice item I see a link to the show page for the bulk discount that was applied' do
            visit merchant_invoice_path(merchant_2, invoice_1)

            within('#4') do
              expect(page).to_not have_link('Show Discount Applied')
              expect(page).to_not have_content('Item Discounted Price:')
            end

            within('#6') do
              expect(page).to have_link('Show Discount Applied')
              expect(page).to have_content('Item Discounted Price:')
            end
          end
        end
      end
    end
  end
end
