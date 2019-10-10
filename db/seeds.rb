User.create(
  username: "beerjeans",
  email: "plm@example.org",
  password: "passwordagain",
  password_confirmation: "passwordagain"
)

30.times do
  name = Faker::Name.first_name
  password = Faker::Internet.password
  User.create(
    username: Faker::Internet.username(specifier: name),
    email: Faker::Internet.email(name: name),
    password: password,
    password_confirmation: password
  )
end

100.times do

  new_tweet = Tweet.create(content: Faker::Hipster.sentence.downcase)
  User.all[rand(0...User.all.length)].tweets << new_tweet
end
