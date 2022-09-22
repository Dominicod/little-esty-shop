require 'rails_helper'

RSpec.describe 'Merchant item create' do
  before(:each) { mock_api_call }

  describe 'As a merchant' do
    describe 'When I visit my merchant items index page ("merchants/merchant_id/items")' do
      it 'I see a link to create a new item' do
        visit merchant_items_path(Merchant.first)

        expect(page).to have_link("Create Item")
      end

      it 'When I click on the link I am taken to a form that allows me to add some item information' do
        visit merchant_items_path(Merchant.first)

        click_link("Create Item")
        expect(current_path).to eq(new_merchant_item_path(Merchant.first))

        fill_in('Name', with: 'Item A')
        fill_in('Description', with: 'Description A')
        fill_in('Unit Price', with: 9999)
      end

      it 'When I fill out thte form, I click Submit, then I am taken back to the items index page, I see the item I just created displayed in the list of items, and I see my item was created with a default status of disabled' do
        visit new_merchant_item_path(Merchant.first)

        fill_in('Name', with: 'Item A')
        fill_in('Description', with: 'Description A')
        fill_in('Unit Price', with: 9999)

        click_button('Save')
        expect(current_path).to eq(merchant_items_path(Merchant.first))

        within "div#Disabled_Items" do
          expect(page).to have_content("Item A")
        end

        within "div#Enabled_Items" do
          expect(page).to_not have_content("Item A")
        end

        expect(page).to have_content("Item successfully created!")
      end

      it 'When I fill out the form incorrectly (leave a field blank) and I click Submit, I get am taken back to the items create page and I see a message that my item is not created' do
        visit new_merchant_item_path(Merchant.first)

        fill_in('Name', with: 'Item A')
        #Description not filled in
        fill_in('Unit Price', with: 9999)

        click_button('Save')
        expect(current_path).to eq(new_merchant_item_path(Merchant.first))

        expect(page).to have_content("Item not created: Additional information required.")
      end
    end
  end
end
