require 'rails_helper'

RSpec.describe "Merchant bulk discounts edit page", type: :feature do
  let(:bulk_discount_1) { Merchant.find(1).bulk_discounts.create!(percentage: "20%", quantity_threshold: 5) }
  let(:bulk_discount_2) { Merchant.find(1).bulk_discounts.create!(percentage: "30%", quantity_threshold: 10) }
  before(:each) { mock_api_call }

  describe 'When I visit my bulk discount edit page' do
    it 'I see that the discounts current attributes are pre-poluated in the form. When I change any/all of the information and click submit
        Then I am redirected to the bulk discounts show page and I see that the discounts attributes have been updated' do
      visit edit_merchant_bulk_discount_path(1, bulk_discount_1)

      within("#edit_bulk_discount") do
        expect(page).to have_field("bulk_discount_percentage")
        expect(page).to have_field("bulk_discount_quantity_threshold")
        fill_in "bulk_discount_percentage", with: "50%"
        fill_in "bulk_discount_quantity_threshold", with: "20"
        click_on "Update Bulk discount"
      end
      expect(page.current_url).to eq merchant_bulk_discount_path(1, bulk_discount_1)

      within("#bulk_discount") do
        within("#discount-#{bulk_discount_1.id}") do
          expect(page).to have_content("50%")
          expect(page).to have_content("20")
        end
      end
    end
  end
end
