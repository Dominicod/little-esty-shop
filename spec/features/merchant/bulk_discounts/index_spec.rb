require 'rails_helper'

RSpec.describe "merchant bulk discounts index page", type: :feature do
  let(:bulk_discount_1) { Merchant.find(1).bulk_discounts.create!(percentage: "20%", quantity_threshold: 5) }
  let(:bulk_discount_2) { Merchant.find(1).bulk_discounts.create!(percentage: "30%", quantity_threshold: 10) }
  before(:each) { mock_api_call }

  describe 'As a merchant, When I visit my merchant dashboard' do
    it 'I see a link to view all my discounts, when I click this link I am then taken to my bulk discounts index page.
              I see all of my bulk discounts including their percentage discount and quantity thresholds and each bulk discount
              listed includes a link to its show page' do
      visit merchant_dashboard_index_path(1)
      bulk_discount_1
      bulk_discount_2

      expect(page).to have_link("All Discounts")
      click_on "All Discounts"

      expect(page.current_path).to eq merchant_bulk_discounts_path(1)

      within("#bulk_discounts") do
        within("#discount-#{bulk_discount_1.id}") do
          expect(page).to have_content("20%")
          expect(page).to have_content("5")
          expect(page).to have_link("Bulk_Discount ##{bulk_discount_1.id}")

          click_on "Bulk_Discount ##{bulk_discount_1.id}"
        end
        expect(page.current_path).to eq merchant_bulk_discount_path(1, bulk_discount_1)
      end
    end
  end
end
