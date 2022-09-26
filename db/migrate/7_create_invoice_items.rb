class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_items do |t|
      t.belongs_to :item, foreign_key: true
      t.belongs_to :invoice, foreign_key: true
      t.belongs_to :bulk_discount, foreign_key: true
      t.integer :quantity, null: false
      t.integer :unit_price, null: false
      t.column :status, :integer, default: 0
      t.integer :discounted_unit_price, default: nil

      t.timestamps
    end
  end
end
