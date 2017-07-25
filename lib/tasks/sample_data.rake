namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationship
  end
end

def make_users
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                  email: email,
                  password: password)
    end
end

def make_microposts
    user = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      user.each { |user| user.microposts.create!(content: content)}
    end
end

def make_relationship
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end