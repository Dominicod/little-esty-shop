require 'rails_helper'

RSpec.describe "Merchant bulk discounts show page", type: :feature do
  let(:bulk_discount_1) { Merchant.find(1).bulk_discounts.create!(percentage: "20%", quantity_threshold: 5) }
  let(:bulk_discount_2) { Merchant.find(1).bulk_discounts.create!(percentage: "30%", quantity_threshold: 10) }
  before(:each) { mock_api_call }

  describe 'When I visit my bulk discount show page' do
    it 'Then I see the bulk discounts quantity threshold and percentage discount' do
      visit merchant_bulk_discount_path(1, bulk_discount_1)

      within("#bulk_discount") do
        within("#discount-#{bulk_discount_1.id}") do
          expect(page).to have_content("20%")
          expect(page).to have_content("5")
        end
      end
    end

    it 'I see a link to edit a bulk discount, when I click the link I am redirected to /edit' do
      visit merchant_bulk_discount_path(1, bulk_discount_1)

      within("#bulk_discount") do
        within("#discount-#{bulk_discount_1.id}") do
          expect(page).to have_link "Edit"
          click_on "Edit"
        end
        expect(page.current_path).to eq edit_merchant_bulk_discount_path(1, bulk_discount_1)
      end
    end
  end
end
