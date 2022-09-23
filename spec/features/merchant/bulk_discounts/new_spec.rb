require 'rails_helper'

RSpec.describe "merchant bulk discounts new page", type: :feature do
  before(:each) { mock_api_call }

  describe 'As a merchant, When I visit my bulk discounts index' do
    it 'Then I see a link to create a new discount.
        When I click this link I am taken to a new page where I see a form to add a new bulk discount
        When I fill in the form with valid dataThen I am redirected back to the bulk discount index And I see my new bulk discount listed' do
      visit merchant_bulk_discounts_path(1)

      within("#bulk_discounts") do
        expect(page).to have_link("Create Discount")
        click_on "Create Discount"
      end
      expect(page.current_path).to eq new_merchant_bulk_discount_path(1)

      within("#new_bulk_discount") do
        expect(page).to have_field("bulk_discount_percentage")
        expect(page).to have_field("bulk_discount_quantity_threshold")
        fill_in "bulk_discount_percentage", with: "50%"
        fill_in "bulk_discount_quantity_threshold", with: "20"
        click_on "Create Bulk discount"
      end
      expect(page.current_path).to eq merchant_bulk_discounts_path(1)

      within("#bulk_discounts") do
        within("#discount-#{BulkDiscount.last.id}") do
          expect(page).to have_content("50%")
          expect(page).to have_content("20")
          expect(page).to have_link("Bulk_Discount ##{BulkDiscount.last.id}")
        end
      end

      within("#flash_message") do
        expect(page).to have_content("Bulk Discount created successfully")
      end
    end

    it "If I attempt to create a new discount and do not fill in the correct information
        I am redirected back to the new page and I am informed via flash message that I entered
        incorrect information." do
      visit new_merchant_bulk_discount_path(1)

      within("#new_bulk_discount") do
        expect(page).to have_field("bulk_discount_percentage")
        expect(page).to have_field("bulk_discount_quantity_threshold")
        fill_in "bulk_discount_percentage", with: "50%"
        click_on "Create Bulk discount"
      end
      expect(page.current_path).to eq new_merchant_bulk_discount_path(1)

      within("#flash_message") do
        expect(page).to have_content("Bulk Discount not created: Missing required information")
      end
    end
  end
end
