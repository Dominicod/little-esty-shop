require 'rails_helper'

RSpec.describe 'As an admin,' do
 describe "When I visit an admin invoice show page" do
   it "Then I see information related to that invoice including:
     - Invoice id
     - Invoice status
     - Invoice created_at date in the format 'Monday, July 18, 2019'
     - Customer first and last name" do

     visit "/admin/invoices/1"

     # save_and_open_page

     expect(page).to have_content("Invoice ID: 1")
     expect(page).to have_content("Invoice ID: 1")
     expect(page).to have_content("cancelled")
     expect(page).to have_content("Created at: 2012-03-25 09:54:09 UTC")
     expect(page).to have_content("Customer: Joey Ondricka")

     expect(page).to_not have_content("Cecelia Osinski")
     expect(page).to have_content("Invoice ID: 2")
     end
   end
 end
