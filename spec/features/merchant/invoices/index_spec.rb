require 'rails_helper'

RSpec.describe 'Merchant Invoices Index Page' do
  before(:each) { mock_api_call }

  describe 'As a merchant' do
    describe 'When I visit my merchant invoices index page' do
      it 'shows me all of the invoices that include at least one of my merchant items' do
        visit merchant_invoices_path(Merchant.first)

        within '#invoices' do
          expect(page).to have_link("Invoice #1")
          expect(page).to have_link("Invoice #5")
        end
      end
    end
  end
end
