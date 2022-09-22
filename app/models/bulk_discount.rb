class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percentage, presence: true
  validates :quantity_threshold, presence: true
end
