require 'rails_helper'

RSpec.describe "As an admin or Merchant", type: :feature do
  before(:each) { mock_api_call }

  it "I see Github information on every page" do
    visit merchant_invoice_path(1,1)

    within("footer") do
      expect(page).to have_content("little-esty-shop")
      expect(page).to have_content("rebeckahendricks")
      expect(page).to have_content("Dominicod")
      expect(page).to have_content("lcole37")
      expect(page).to have_content("thayes87")
      expect(page).to have_content("2")
    end
  end
end