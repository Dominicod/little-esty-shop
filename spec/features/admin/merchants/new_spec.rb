require 'rails_helper'

RSpec.describe 'As an admin,' do
  before(:each) { mock_api_call }

  describe "When I visit a merchant's admin new page" do
    it "When I fill out the form I click ‘Submit’, Then I am taken back to the admin merchants index page" do
      visit new_admin_merchant_path

      within("#new_merchant") do
        expect(page).to have_field("merchant_name")
        fill_in "merchant_name", with: "Dominic's Shop"
        click_on "Create Merchant"
      end

      expect(page.current_path).to eq admin_merchants_path
      expect(page.current_path).not_to eq(new_admin_merchant_path)
    end

    it "When I click ‘Submit’ without filling the form, Then a flash message is displayed, requesting more information" do
      visit new_admin_merchant_path

      within("#new_merchant") do
        expect(page).to have_field("merchant_name")

        click_on "Create Merchant"

        expect(current_path).to eq(new_admin_merchant_path)
        expect(page.current_path).not_to eq admin_merchants_path
      end

      expect(page).to have_content("Merchant not created: Missing required information")
    end

    it "I see the merchant I just created displayed and I see my merchant was created with a default status of disabled." do
      visit new_admin_merchant_path

      within("#new_merchant") do
        expect(page).to have_field("merchant_name")
        fill_in "merchant_name", with: "Dominic's Shop"
        click_on "Create Merchant"
      end

      expect(page.current_path).to eq admin_merchants_path

      within("#disabled_merchants") do
        expect(page).to have_content("Dominic's Shop")
      end
    end
  end
end
