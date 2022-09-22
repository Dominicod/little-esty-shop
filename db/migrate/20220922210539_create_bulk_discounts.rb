class CreateBulkDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bulk_discounts do |t|
      t.string :percentage
      t.integer :quantity_threshold
      t.belongs_to :merchant, foreign_key: true

      t.timestamps
    end
  end
end
