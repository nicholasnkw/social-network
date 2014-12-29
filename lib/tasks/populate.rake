namespace :db do
  desc "Populate the database"
  task populate: :environment do    
    [User, Profile, Friendship, Post, Comment, Like].each(&:delete_all)
    make_users
    make_profiles
  end
  
  def make_users

    10.times do |n|
      email = Faker::Internet.email
      password = "password"
      User.create!(id: n,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end
  end
    
    def make_profiles

      10.times do |n|
        user_id = n
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        blurb = Faker::Hacker.say_something_smart
        Profile.create!(user_id: user_id,
                        first_name: first_name,
                        last_name: last_name,
                        blurb: blurb
          )
      end
    end
end
