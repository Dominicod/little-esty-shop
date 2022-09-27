require 'rails_helper'

RSpec.describe "merchant bulk discounts index page", type: :feature do
  let(:bulk_discount_1) { Merchant.find(1).bulk_discounts.create!(percentage: "20%", quantity_threshold: 5) }
  let(:bulk_discount_2) { Merchant.find(1).bulk_discounts.create!(percentage: "30%", quantity_threshold: 10) }
  before(:each) { mock_api_call }

  describe 'As a merchant, When I visit my bulk discounts index' do
    it 'I see all of my bulk discounts including their percentage discount and quantity
        thresholds and each bulk discount listed includes a link to its show page' do
      bulk_discount_1
      bulk_discount_2

      visit merchant_dashboard_index_path(1)

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

    it 'Then next to each bulk discount I see a link to delete it. When I click this link
        Then I am redirected back to the bulk discounts index page
        And I no longer see the discount listed' do
      bulk_discount_1
      bulk_discount_2

      visit merchant_bulk_discounts_path(1)

      within("#bulk_discounts") do
        within("#discount-#{bulk_discount_1.id}") do
          expect(page).to have_content("20%")
          expect(page).to have_content("5")
          expect(page).to have_link("Bulk_Discount ##{bulk_discount_1.id}")
          expect(page).to have_button("Delete")

          click_on "Delete"
        end
        expect(page.current_path).to eq merchant_bulk_discounts_path(1)

        expect(page).to_not have_content("#discount-#{bulk_discount_1.id}")
      end

      within("#flash_message") do
        expect(page).to have_content("Bulk Discount deleted successfully")
      end
    end

    it 'I see a section with a header of "Upcoming Holidays"' do
      bulk_discount_1
      bulk_discount_2

      visit merchant_bulk_discounts_path(1)

      within("#upcoming_holidays") do
      expect(page).to have_content "Upcoming Holidays"
      end
    end
  end

  it 'In this section the name and date of the next 3 upcoming US holidays are listed.' do
    bulk_discount_1
    bulk_discount_2

    visit merchant_bulk_discounts_path(1)

    within("#upcoming_holidays") do
      expect(page).to have_content "Columbus Day"
      expect(page).to have_content "Veterans Day"
      expect(page).to have_content "Thanksgiving Day"
    end
  end
end
