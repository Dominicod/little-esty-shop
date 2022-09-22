require 'rails_helper'

RSpec.describe 'As an admin,' do
  before(:each) { mock_api_call }

  describe "When I visit a merchant's admin edit page" do
    it "I see a form filled in with the existing merchant attribute information" do
      visit admin_merchants_path

      within("#disabled_merchants") do
        expect(page).to have_link("Schroeder-Jerde")
        click_link "Schroeder-Jerde"
        expect(page.current_path).to eq admin_merchant_path(1)
      end

      expect(page).to have_link("Update Merchant")
      click_link "Update Merchant"
      expect(page.current_path).to eq edit_admin_merchant_path(1)

      within("#update_merchant") do
        merchant_name = find("#merchant_name")

        expect(merchant_name.value).to eq "Schroeder-Jerde"
      end
    end

    it "When I update the information in the form and I click ‘submit’, Then I am redirected back to the merchant's admin show page where I see the updated information" do
      visit admin_merchants_path

      within("#disabled_merchants") do
        expect(page).to have_link("Schroeder-Jerde")
        click_link "Schroeder-Jerde"
        expect(page.current_path).to eq admin_merchant_path(1)
      end

      expect(page).to have_link("Update Merchant")
      click_link "Update Merchant"
      expect(page.current_path).to eq edit_admin_merchant_path(1)

      within("#update_merchant") do
        merchant_name = find("#merchant_name")

        expect(merchant_name.value).to eq "Schroeder-Jerde"
        fill_in "merchant_name", with: "test_merchant"
        click_on "Update Merchant"
      end

      expect(page.current_path).to eq admin_merchant_path(1)
      expect(page).to have_content("test_merchant")
      expect(page).to_not have_content("Schroeder-Jerde")
    end
    end

    it "I see a flash message stating that the information has been successfully updated." do
      visit admin_merchants_path

      within("#disabled_merchants") do
        expect(page).to have_link("Schroeder-Jerde")
        click_link "Schroeder-Jerde"
        expect(page.current_path).to eq admin_merchant_path(1)
      end

      expect(page).to have_link("Update Merchant")
      click_link "Update Merchant"
      expect(page.current_path).to eq edit_admin_merchant_path(1)

      within("#update_merchant") do
        merchant_name = find("#merchant_name")

        expect(merchant_name.value).to eq "Schroeder-Jerde"
        fill_in "merchant_name", with: "test_merchant"
        click_on "Update Merchant"
      end

      expect(page.current_path).to eq admin_merchant_path(1)
      expect(page).to have_content("test_merchant")
      expect(page).to_not have_content("Schroeder-Jerde")

      within("#flash_message") do
        expect(page).to have_content("Updated Successfully")
      end
    end

    it "I see a flash message stating that the merchant failed to update if not given the correct information" do
      visit admin_merchants_path

      within("#disabled_merchants") do
        expect(page).to have_link("Schroeder-Jerde")
        click_link "Schroeder-Jerde"
        expect(page.current_path).to eq admin_merchant_path(1)
      end

      expect(page).to have_link("Update Merchant")
      click_link "Update Merchant"
      expect(page.current_path).to eq edit_admin_merchant_path(1)

      within("#update_merchant") do
        merchant_name = find("#merchant_name")

        expect(merchant_name.value).to eq "Schroeder-Jerde"
        fill_in "merchant_name", with: ""
        click_on "Update Merchant"
      end

      expect(page.current_path).to eq admin_merchant_path(1)
      expect(page).to have_content("Schroeder-Jerde")

      within("#flash_message") do
        expect(page).to have_content("Merchant not updated, additional information required.")
      end
    end
  end