namespace :db do
  desc "Fill database with data"
  task populate: :environment do
    make_admin_user
    # make_admin_users
    # make_users
    # make_categories
    # make_quizzes
    # make_results
  end
end

def make_admin_user
  AdminUser.create!(first_name:     "Admin",
                    last_name:      "default",
                    email:          "admin@snout.com.my",
                    password:       "123456",
                    password_confirmation: "123456")
end

def make_admin_users
  AdminUser.create!(first_name:     "Admin",
                    last_name:      "default",
                    email:          "admin@snout.com.my",
                    password:       "123456",
                    password_confirmation: "123456")
    99.times do |n|
      first_name  = Faker::Name.first_name
      last_name  = Faker::Name.last_name
      email = "example-#{n+1}@snout.com.my"
      password  = "123456"
      AdminUser.create!(first_name:     first_name,
                   last_name:     last_name,
                   email:    email,
                   password: password,
                   password_confirmation: password)
    end
end

def make_users
    100.times do |n|
      first_name  = Faker::Name.first_name
      last_name  = Faker::Name.last_name
      email = "user-#{n+1}@snout.com.my"
      password  = "123456"
      User.create!(first_name:     first_name,
                   last_name:     last_name,
                   email:    email,
                   password: password,
                   password_confirmation: password)
    end
end

def make_categories
    100.times do |n|
      name  = Faker::Lorem.sentence(1)
      description  = Faker::Lorem.paragraph(1)
      Category.create!(name:     name,
                   description:     description)
    end
end

def make_quizzes
  categories = Category.all(limit: 6)
  50.times do |n|
    categories.each do |category|
      name  = Faker::Lorem.sentence(1)
      description  = Faker::Lorem.sentence(3)
      category.quizzes.create!(name: name,
                           description: description,
                           random_flag: false,
                           max_question: 100,
                           deleted_flag: false)
    end
  end
end

def make_results
  users = User.all(limit: 6)
  50.times do |n|
    users.each do |user|
      user.results.create!(quiz_id: n,
                           start_time: Time.now + n.second,
                           end_time: Time.now + 1.hour + (n*2).second,
                           marks: n,
                           comment: "",
                           retry_count: n)
    end
  end
end