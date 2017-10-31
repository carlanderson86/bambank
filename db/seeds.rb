# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Starter Promotion
promotion = Promotion.where('name=?','bambank_welcome').take
if promotion.blank?
  Promotion.create(label:'Welcome to Bambank',name:'bambank_welcome',value:100.0,is_active:true, promotion_type:Promotion::SIGN_UP_PROMOTION)
end