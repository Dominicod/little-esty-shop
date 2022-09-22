require 'rails_helper'

RSpec.describe 'merchant items show page' do
  before(:each) { mock_api_call }

  describe 'as a merchant, when I click on the name of an item from the merchant items index page' do
    it 'I am taken to that merchants items show page' do
      visit merchant_item_path(1, 1)
      expect(page).to have_content("Item Qui Esse")
      expect(page).to have_content("Nihil autem sit odio inventore deleniti. Est lauda")
      expect(page).to have_content("$751.07")
    end
  end  
end
