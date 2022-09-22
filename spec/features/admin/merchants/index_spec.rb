require 'rails_helper'

RSpec.describe 'As an admin,' do
  before(:each) { mock_api_call }

  describe 'When I visit the admin Merchants index ("/admin/merchants")' do
    it 'Then I see the name of each merchant in the system' do
      visit admin_merchants_path

      within("#merchant_names") do
        merchant_ids = (1..30).to_a

        expect(page).to have_link("Schroeder-Jerde")
        expect(page).to have_link("Pollich and Koelpin")
        expect(page).to have_link("Jones and Stokes")
        expect(page).to have_link("Ernser, Borer and Marks")

        merchant_ids.each {|id| expect(page.has_css?("##{id}")).to eq true}
      end
    end

    it "When I click on the name of a merchant from the admin merchants index page, I am taken to that merchant's admin show page (/admin/merchants/merchant_id)" do
      visit admin_merchants_path

      within("#merchant_names") do
        expect(page).to have_link("Schroeder-Jerde")
        click_link "Schroeder-Jerde"
        expect(page.current_path).to eq admin_merchant_path("1")

        visit admin_merchants_path

        expect(page).to have_link("Ernser, Borer and Marks")
        click_link "Ernser, Borer and Marks"
        expect(page.current_path).to eq admin_merchant_path("30")
      end
    end

    it "Next to each merchant name I see a button to disable or enable that merchant." do
      visit admin_merchants_path

      within("#merchant_names") do
        expect(page).to have_button("enable")
        within("#1") do
          click_on "enable"
        end
        expect(page).to have_button("disable")
      end
    end

    it "When I click this button, Then I am redirected back to the admin merchants index, and I see that the merchant's status has changed" do
      visit admin_merchants_path

      within("#disabled_merchants") do
        expect(find_all("li").count).to eq 30

        within("#1") do
          expect(page).to have_button("enable")
          click_on "enable"
          expect(page.current_path).to eq admin_merchants_path
        end

        expect(find_all("li").count).to eq 29
      end

      within("#enabled_merchants") do
        within("#1") do
          expect(page).to have_button("disable")
          expect(page).to_not have_button("enable")
        end
      end
    end

    it "Then I see two sections, one for 'Enabled Merchants' and one for 'Disabled Merchants'" do
      visit admin_merchants_path

      within("#merchant_names") do
        expect(page).to have_content("Disabled Merchants")
        expect(page).to have_content("Enabled Merchants")
      end
    end

    it "I see that each Merchant is listed in the appropriate section" do
      visit admin_merchants_path

      within("#disabled_merchants") do
        within("#1") do
          expect(page).to have_button("enable")
          click_on "enable"
          expect(page.current_path).to eq admin_merchants_path
        end

        visit admin_merchants_path
        within("#2") do
          expect(page).to have_button("enable")
          click_on "enable"
          expect(page.current_path).to eq admin_merchants_path
          visit admin_merchants_path
        end

        visit admin_merchants_path
        within("#3") do
          expect(page).to have_button("enable")
          click_on "enable"
          expect(page.current_path).to eq admin_merchants_path
        end
      end

      within("#enabled_merchants") do
        expect(find_all("li").count).to eq 3
        expect(page).to have_content("Schroeder-Jerde")
        expect(page).to have_content("Klein, Rempel and Jones")
        expect(page).to have_content("Willms and Sons")
      end
    end

    it "I see a link to create a new merchant When I click on the link, I am taken to a form that allows me to add merchant information." do
      visit admin_merchants_path

      expect(page).to have_link("New Merchant")
      click_on "New Merchant"

      expect(page.current_path).to eq new_admin_merchant_path

      within("#new_merchant") do
        expect(page).to have_field("merchant_name")
      end
    end

    it "I see the names of the top 5 merchants by total revenue generated" do
      visit admin_merchants_path

      within("#top_five_merchants") do
        expect(page).to have_content("Klein, Rempel and Jones")
        expect(page).to have_content("Schroeder-Jerde")
        expect(page).to have_content("Willms and Sons")
        expect(page).to have_content("Cummings-Thiel")
        expect(page).to have_content("Williamson Group")
        expect(page).to_not have_content("Bosco, Howe and Davis")
        expect(page).to_not have_content("Ullrich-Moen")
      end
    end

    it "I see that each merchant name links to the admin merchant show page for that merchant" do
      visit admin_merchants_path

      within("#top_five_merchants") do
        expect(page).to have_link("Klein, Rempel and Jones")
        expect(page).to have_link("Schroeder-Jerde")
        expect(page).to have_link("Willms and Sons")
        expect(page).to have_link("Cummings-Thiel")
        expect(page).to have_link("Williamson Group")
        expect(page).to_not have_link("Bosco, Howe and Davis")
        expect(page).to_not have_link("Ullrich-Moen")

        click_on "Klein, Rempel and Jones"

        expect(page.current_path).to eq admin_merchant_path(2)
      end
    end

    it "I see the total revenue generated next to each merchant name" do
      visit admin_merchants_path

      within("#top_five_merchants") do
        within("#2") do
          expect(page).to have_link("Klein, Rempel and Jones")
          expect(page).to have_content("$85388.60")
        end
        within("#1") do
          expect(page).to have_link("Schroeder-Jerde")
          expect(page).to have_content("$33455.31")
        end
        within("#3") do
          expect(page).to have_link("Willms and Sons")
          expect(page).to have_content("$18427.08")
        end
        within("#4") do
          expect(page).to have_link("Cummings-Thiel")
          expect(page).to have_content("$3185.18")
        end
        within("#6") do
          expect(page).to have_link("Williamson Group")
          expect(page).to have_content("$2532.18")
        end
        expect(page).to_not have_link("Bosco, Howe and Davis")
        expect(page).to_not have_content("49896565")
        expect(page).to_not have_link("Ullrich-Moen")
        expect(page).to_not have_content("3974755")
      end
    end

    it "Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant. ('Top selling date for <merchant name> was <date with most sales>')" do
      visit admin_merchants_path

      within("#top_five_merchants") do
        within("#2") do
          expect(page).to have_link("Klein, Rempel and Jones")
          expect(page).to have_content("$85388.60")
          expect(page).to have_content("Top selling date for Klein, Rempel and Jones was '3/25/2012'")
        end
        within("#1") do
          expect(page).to have_link("Schroeder-Jerde")
          expect(page).to have_content("$33455.31")
          expect(page).to have_content("Top selling date for Schroeder-Jerde was '3/25/2012'")
        end
        within("#3") do
          expect(page).to have_link("Willms and Sons")
          expect(page).to have_content("$18427.08")
          expect(page).to have_content("Top selling date for Willms and Sons was '3/7/2012'")
        end
        within("#4") do
          expect(page).to have_link("Cummings-Thiel")
          expect(page).to have_content("$3185.18")
          expect(page).to have_content("Top selling date for Cummings-Thiel was '3/12/2012'")
        end
        within("#6") do
          expect(page).to have_link("Williamson Group")
          expect(page).to have_content("$2532.18")
          expect(page).to have_content("Top selling date for Williamson Group was '3/10/2012'")
        end
        expect(page).to_not have_link("Bernhard-Johns")
        expect(page).to_not have_content("49896565")
        expect(page).to_not have_content("Top selling date for Bernhard-Johns was '3/9/2012'")

        expect(page).to_not have_link("Pollich and Sons")
        expect(page).to_not have_content("3974755")
        expect(page).to_not have_content("Top selling date for Pollich and Sons was '3/9/2012'")
      end
    end
  end
end
