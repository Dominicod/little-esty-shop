require 'rails_helper'

RSpec.describe 'merchant items show page' do
  describe 'When I visit the merchant show page of an item' do
    it 'I see a link to update the item information with all the necessary information' do
      visit merchant_item_path(1, 1)
      
      expect(page).to have_link("Edit")

      click_link("Edit")

      expect(current_path).to eq(edit_merchant_item_path(1, 1))
      
      fill_in 'name', with: "Item A"
      fill_in 'description', with: 'Description A'
      fill_in 'unit_price', with: '11111'
      click_button 'Save'

      expect(current_path).to eq(merchant_item_path(1, 1))
      expect(page).to have_content("Item A")
      expect(page).to have_content("Description A")
      expect(page).to have_content("$111.11")
      
      expect(page).to have_content("Item successfully updated.")
    end
  end
  
  describe 'When I visit the merchant show page of an item' do
    it 'I see a link to update the item information correctly and get a message that information is missing' do #sad path
      visit merchant_item_path(1, 1)
      
      expect(page).to have_link("Edit")

      click_link("Edit")

      expect(current_path).to eq(edit_merchant_item_path(1, 1))
    
      fill_in 'name', with: ""
      fill_in 'description', with: 'Description A'
      fill_in 'unit_price', with: '11111'
      click_button 'Save'

      expect(page).to have_content("Item not updated, additional information required.")
      expect(current_path).to eq(merchant_item_path(1, 1))
      expect(page).to have_content("Description A")
      expect(page).to have_content("$111.11")
      #do we need to test a flash message since it is being handled by the framework?
    end 
  end
end


# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.