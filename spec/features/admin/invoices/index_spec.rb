require 'rails_helper'

RSpec.describe 'As an admin,' do
  before(:each) { mock_api_call }

  describe 'When I visit the admin Invoices index ("/admin/invoices")' do
    describe "navbar" do
      it "I see a header indicating that I am on the admin dashboard" do
        visit admin_invoices_path

        expect(page).to have_content "Admin Dashboard"
      end

      it "I see a link to the admin merchants index (/admin/merchants), and I can click said link to go to the correct path" do
        visit admin_invoices_path
      
        expect(page).to have_link("Dashboard")
        click_link "Dashboard"
        expect(page.current_path).to eq admin_index_path
      end

      it "I see a link to the admin merchants index (/admin/merchants), and I can click said link to go to the correct path" do
        visit admin_invoices_path

        expect(page).to have_link("Merchants")
        click_link "Merchants"
        expect(page.current_path).to eq admin_merchants_path
      end

      it "I see a link to the admin invoices index (/admin/invoices), and I can click said link to go to the correct path " do
        visit admin_invoices_path

        expect(page).to have_link("Invoices")
        click_link "Invoices"
        expect(page.current_path).to eq admin_invoices_path
      end
    end

    it 'Then I see a list of all Invoice ids in the system' do
      visit admin_invoices_path

      expect(page).to have_content("Invoice #1")
      expect(page).to have_content("Invoice #2")
      expect(page).to have_content("Invoice #3")
      expect(page).to have_content("Invoice #4")
    end

    it 'Each id links to the admin invoice show page' do
      visit admin_invoices_path

      expect(page).to have_link("Invoice #1")
      expect(page).to have_link("Invoice #2")
      expect(page).to have_link("Invoice #3")
      expect(page).to have_link("Invoice #4")
    end
  end
end
