# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do |n|
  name = Faker::Name.unique.name
  email = Faker::Internet.email
  password = "password"
  random = User.create_unique_string
  title = Faker::Pokemon.name
  content = Faker::Company.catch_phrase
  fakes = ['app/assets/images/fakehito.jpg', 'app/assets/images/fakepika.jpg', 'app/assets/images/fakezeni.jpg', 'app/assets/images/fakepoke.jpg']
  imgs = fakes.sample

  user = User.new(
    name: name,
    email: email,
    uid: random,
    provider: "",
    password: password,
    password_confirmation: password,
  )
  user.skip_confirmation!
  user.save

  user.topics.create!(
    title: title,
    content: content,
    topic_img: open("#{Rails.root}/#{imgs}")
  )

  5.times do |c|
    comment = Faker::Hipster.sentence
    Comment.create!(
      user_id: n+1,
      topic_id: n+1,
      content: comment
    )
  end

 end