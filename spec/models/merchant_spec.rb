require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:bulk_discounts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    describe '.enabled_items' do
      it 'returns a list of all the items that are enabled for a specific merchant' do
        merchant = Merchant.first
        expect(merchant.enabled_items.count).to eq(0)

        merchant.items.first.update(status: "enabled")
        expect(merchant.enabled_items.count).to eq(1)
      end
    end

    describe '.disabled_items' do
      it 'returns a list of all the items that are disabled for a specific merchant' do
        merchant = Merchant.first
        expect(merchant.disabled_items.count).to eq(3)

        merchant.items.first.update(status: "enabled")
        expect(merchant.disabled_items.count).to eq(2)
      end
    end

    describe "top_five_by_revenue" do
      it "returns the top five merchants by revenue" do
        klein = Merchant.find(2)
        schroeder = Merchant.find(1)
        willms = Merchant.find(3)
        cummings = Merchant.find(4)
        williamson = Merchant.find(6)

        expected_arr = [klein, schroeder, willms, cummings, williamson]

        expect(Merchant.top_five_by_revenue).to eq(expected_arr)
      end
    end

    describe "best_day" do
      it "Returns the date of a merchants best day by revenue" do
        klein = Merchant.find(2)
        schroeder = Merchant.find(1)
        willms = Merchant.find(3)
        cummings = Merchant.find(4)
        williamson = Merchant.find(6)

        expect(klein.best_day).to eq "2012-03-25 09:54:09"
        expect(schroeder.best_day).to eq "2012-03-25 09:54:09"
        expect(willms.best_day).to eq "2012-03-07 19:54:10"
        expect(cummings.best_day).to eq "2012-03-12 05:54:09"
        expect(williamson.best_day).to eq "2012-03-10 00:54:09"
      end
    end
  end
end
