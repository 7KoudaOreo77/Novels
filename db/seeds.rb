# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# clear all
# Admin.destroy_all
# User.destroy_all


Admin.create(name: "aaa", email: "aaa@aaa", password: "aaaaaa")

# user create
(1..10).each do |n|
  User.create!(name: "user#{n}", email: "user#{n}@user.com", password: "password")
end

# novel create
User.limit(6).each do |user|
  rand(1..3).times do
    user.novels.create!(title: "title_#{user.id}", caption: Faker::JapaneseMedia::Naruto.character)
  end
end

# example: {11=>3, 12=>3, 13=>3, 14=>3, 15=>3, 16=>2}
novel_user_id_group = Novel.group('user_id').count
# novel_body create
Novel.count.times do |n|
  # novel.user.novels.length => max novel count
  novel = Novel.offset(n - 1).limit(1).first
  NovelBody.create!(novel_id: novel.id, subtitle: "#{rand(1..5)}章", body: Faker::Lorem.paragraph_by_chars(number: rand(200..256), supplemental: false), position: 3)
end

NovelBody.all.each do |novel_body|
  novel_body.update(position: rand(1..novel_user_id_group[novel_body.novel.user_id]))
end

User.limit(6).each do |user|
  rand(1..2).times do |m|
    novel = user.novels.create!(title: "title_#{user.id}", caption: Faker::JapaneseMedia::Naruto.character)
    (1..5).each do |o|
      novel.bodies.create!(subtitle: "#{o}章", body: Faker::Lorem.paragraph_by_chars(number: rand(200..256)), position: o)
    end
  end
end

(1..10).each do |n|
  Tag.create!(name: Faker::Name.first_name)
end

Novel.all.each do |novel|
  rand(1..3).times do
    novel.novel_tags.create!(novel_id: novel.id, tag_id: rand(Tag.first.id..Tag.last.id))
  end
end
