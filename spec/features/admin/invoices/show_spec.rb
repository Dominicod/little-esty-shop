require 'rails_helper'

RSpec.describe 'As an admin,' do
  before(:each) { mock_api_call }

  describe "When I visit an admin invoice show page" do
    before :each do
      visit admin_invoice_path(Invoice.first)
    end

    describe "links" do
      it "I see a header indicating that I am on the admin dashboard" do
        visit admin_invoice_path(Invoice.first)

        expect(page).to have_content "Admin Dashboard"
      end

      it "I see a link to the admin merchants index (/admin/merchants), and I can click said link to go to the correct path" do
        visit admin_invoice_path(Invoice.first)

        expect(page).to have_link("Dashboard")
        click_link "Dashboard"
        expect(page.current_path).to eq admin_index_path
      end

      it "I see a link to the admin merchants index (/admin/merchants), and I can click said link to go to the correct path" do
        visit admin_invoice_path(Invoice.first)

        expect(page).to have_link("Merchants")
        click_link "Merchants"
        expect(page.current_path).to eq admin_merchants_path
      end

      it "I see a link to the admin invoices index (/admin/invoices), and I can click said link to go to the correct path " do
        visit admin_invoice_path(Invoice.first)

        expect(page).to have_link("Invoices")
        click_link "Invoices"
        expect(page.current_path).to eq admin_invoices_path
      end
    end

    it "Then I see information related to that invoice including:
      - Invoice id
      - Invoice status
      - Invoice created_at date in the format 'Monday, July 18, 2019'
      - Customer first and last name" do

      expect(page).to have_content("Invoice ID: 1")
      expect(page).to have_content("cancelled")
      expect(page).to have_content("Created at: Sunday, March 25, 2012")
      expect(page).to have_content("Customer: Joey Ondricka")

      expect(page).to_not have_content("Cecelia Osinski")
      expect(page).to_not have_content("Invoice ID: 2")
    end

    it "Then I see all of the items on the invoice including:
      - Item name
      - The quantity of the item ordered
      - The price the Item sold for
      - The Invoice Item status" do

      expect(page).to have_content("Invoice Items")
      expect(page).to have_content("Item Qui Esse")
      expect(page).to have_content("Quantity: 5")
      expect(page).to have_content("Unit Price: $751.07")
      expect(page).to have_content("Status: shipped")

      expect(page).not_to have_content("Item Eos Quia")
      expect(page).not_to have_content("Packaged")
    end

    it "Then I see the total revenue that will be generated from this invoice" do
      expect(page).to have_content("Total Invoice Revenue: $21067.77")
    end

    it "I see the invoice status is a select field, And I see that the invoice's current status is selected" do
      # expect(page).to have_form("status")
      expect(page).to have_content("cancelled")
      #unsure how to check for select field, or preselected status
    end

    it "When I click this select field, Then I can select a new status for the Invoice,
      And next to the select field I see a button to Update Invoice Status
      When I click this button
      I am taken back to the admin invoice show page
      and I see that my Invoice's status has now been updated" do

      expect(page).to have_content("cancelled")
      expect(page).to have_button("Update Invoice Status")

      select('completed', from: 'invoice_status')

      click_button("Update Invoice Status")
      expect(current_path).to eq(admin_invoice_path(Invoice.first))
      expect(page).to have_content("Customer: Joey Ondricka")
      expect(page).to have_content("completed")

      # expect(page).to_not have_content("in_progress") must be in within block
      expect(page).to_not have_content("Cecelia Osinski")
    end
  end
end
