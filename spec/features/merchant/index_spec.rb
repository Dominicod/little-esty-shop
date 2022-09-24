require 'rails_helper'

RSpec.describe 'Merchant Index Page', type: :feature do
  before(:each) { mock_api_call }

  describe 'As a customer' do
    describe 'When I visit the merchant index page' do
      it 'shows me all of the merchants' do
        visit merchants_path

        merchants = Merchant.all
        within '#merchants' do
          merchants.each do |merchant|
            expect(page).to have_link(merchant.name)
          end
        end
      end
    end
  end
end
