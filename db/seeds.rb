# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@merchant_1 = Merchant.find(1)
@merchant_2 = Merchant.find(2)
@merchant_3 = Merchant.find(3)

@merchant_1.bulk_discounts.create!(percentage: "25%", quantity_threshold: 2)
@merchant_1.bulk_discounts.create!(percentage: "85%", quantity_threshold: 5)
InvoiceItem.find(1).update(bulk_discount_id: 2, discounted_unit_price: 204525)
InvoiceItem.find(2).update(bulk_discount_id: 2, discounted_unit_price: 349860)
InvoiceItem.find(3).update(bulk_discount_id: 2, discounted_unit_price: 523095)
InvoiceItem.find(7).update(bulk_discount_id: 1, discounted_unit_price: 5006025)
InvoiceItem.find(25).update(bulk_discount_id: 2, discounted_unit_price: 48519)

@merchant_2.bulk_discounts.create!(percentage: "50%", quantity_threshold: 5)
@merchant_2.bulk_discounts.create!(percentage: "30%", quantity_threshold: 7)
InvoiceItem.find(5).update(bulk_discount_id: 3, discounted_unit_price: 39570)
InvoiceItem.find(6).update(bulk_discount_id: 3, discounted_unit_price: 26050)
InvoiceItem.find(8).update(bulk_discount_id: 3, discounted_unit_price: 384695)
InvoiceItem.find(12).update(bulk_discount_id: 3, discounted_unit_price: 155495)
InvoiceItem.find(17).update(bulk_discount_id: 3, discounted_unit_price: 231915)
InvoiceItem.find(19).update(bulk_discount_id: 3, discounted_unit_price: 24359)
InvoiceItem.find(20).update(bulk_discount_id: 3, discounted_unit_price: 36009)
InvoiceItem.find(24).update(bulk_discount_id: 3, discounted_unit_price: 245605)

@merchant_3.bulk_discounts.create!(percentage: "20%", quantity_threshold: 5)
@merchant_3.bulk_discounts.create!(percentage: "10%", quantity_threshold: 2)
InvoiceItem.find(9).update(bulk_discount_id: 5, discounted_unit_price: 239784)
InvoiceItem.find(10).update(bulk_discount_id: 6, discounted_unit_price: 16731)
InvoiceItem.find(26).update(bulk_discount_id: 5, discounted_unit_price: 587264)
