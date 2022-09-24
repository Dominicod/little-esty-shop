require 'rails_helper'

RSpec.describe 'As an admin,' do
  before(:each) { mock_api_call }

  describe 'As a Admin or Merchant' do
    it "I see Github information on every page" do
      visit new_admin_merchant_path

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

  describe "When I visit a merchant's admin show page" do
    it "I see the name of that merchant after clicking the merchant link on the index page" do
      visit admin_merchants_path

      within("#merchant_names") do
        expect(page).to have_link("Schroeder-Jerde")
        click_link "Schroeder-Jerde"
        expect(page.current_path).to eq admin_merchant_path("1")
      end

      expect(page).to have_content("Schroeder-Jerde")
      expect(page).to_not have_content("Ernser, Borer and Marks")
      expect(page).to_not have_content("Jones and Stokes")

      visit admin_merchants_path

      within("#merchant_names") do
        expect(page).to have_link("Ernser, Borer and Marks")
        click_link "Ernser, Borer and Marks"
        expect(page.current_path).to eq admin_merchant_path("30")
      end

      expect(page).to have_content("Ernser, Borer and Marks")
      expect(page).to_not have_content("Schroeder-Jerde")
      expect(page).to_not have_content("Jones and Stokes")
    end

    it "Then I see a link to update the merchant's information. When I click the link, then I am taken to a page to edit this merchant" do
      visit admin_merchants_path

      within("#merchant_names") do
        expect(page).to have_link("Schroeder-Jerde")
        click_link "Schroeder-Jerde"
        expect(page.current_path).to eq admin_merchant_path("1")
      end

      expect(page).to have_link("Update Merchant")
      click_link "Update Merchant"
      expect(page.current_path).to eq edit_admin_merchant_path(1)
    end

    it "I see a link to show that merchants dashboard page" do
      visit admin_merchant_path("1")

      within("#merchant_name") do
        expect(page).to have_link("Show Merchant")
        click_link "Show Merchant"
        expect(page.current_path).to eq merchant_dashboard_index_path("1")
      end
    end
  end
end