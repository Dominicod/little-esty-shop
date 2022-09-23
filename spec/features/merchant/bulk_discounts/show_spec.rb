require 'rails_helper'

RSpec.describe "merchant bulk discounts index", type: :feature do
  let(:bulk_discount_1) { Merchant.find(1).bulk_discounts.create!(percentage: "20%", quantity_threshold: 5) }
  let(:bulk_discount_2) { Merchant.find(1).bulk_discounts.create!(percentage: "30%", quantity_threshold: 10) }
  before(:each) { mock_api_call }

  describe 'As a merchant, When I visit my merchant dashboard' do
    it 'When I visit my bulk discount show page
        Then I see the bulk discounts quantity threshold and percentage discount' do
      visit merchant_bulk_discount_path(1, bulk_discount_1)

      within("#bulk_discount") do
        within("#discount-#{bulk_discount_1.id}") do
          expect(page).to have_content("20%")
          expect(page).to have_content("5")
        end
      end
    end
  end
end
