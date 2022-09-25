require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:percentage) }
    it { should validate_presence_of(:quantity_threshold) }
  end

  describe 'Class Methods' do
    describe '.max_discount' do
      it 'Returns the max possible discount an invoice_item qualifies for' do
        bulk_discount = BulkDiscount.find(2)
        expect(BulkDiscount.max_discount(1,1)).to eq bulk_discount

        bulk_discount = BulkDiscount.find(1)
        expect(BulkDiscount.max_discount(7,1)).to eq bulk_discount
      end
    end
  end
end
