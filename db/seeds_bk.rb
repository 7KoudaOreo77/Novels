# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# if Rails.env.development?
#   Admin.create(name: "aaa", email: "aaa@aaa", password: "aaaaaa")

#   (1..10).each do |n|
#     user = User.create!(name: "user#{n}", email: "user#{n}@user.com", password: "password")
#     if n <= 6
#       rand(1..2).times do |m|
#         novel = user.novels.create!(title: "xxxxxxx#{m + 1}", caption: ("x" * 10 * rand(5..10) + "\n")  * rand(1..3))
#         (1..5).each do |o|
#           novel.bodies.create!(subtitle: "#{o}章",body: ("x" * 10 * rand(10..20) + "\n")  * rand(10..100), position: o)
#         end
#       end
#     end
#   end
# end