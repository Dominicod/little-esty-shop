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

@merchant_2.bulk_discounts.create!(percentage: "50%", quantity_threshold: 5)
@merchant_2.bulk_discounts.create!(percentage: "30%", quantity_threshold: 7)

@merchant_3.bulk_discounts.create!(percentage: "20%", quantity_threshold: 5)
@merchant_3.bulk_discounts.create!(percentage: "10%", quantity_threshold: 2)
