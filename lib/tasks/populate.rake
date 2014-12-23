namespace :db do
  desc "Populate the database"
  task populate: :environment do    
    [User, Profile, Friendship].each(&:delete_all)
    make_users
    make_profiles
  end
  
  def make_users
    User.create!(id: 28,
                email: "davidjanczyn@gmail.com",
      password: "surfdemon1?",
                password_confirmation: "surfdemon1?")
        User.create!(id: 29,
                email: "davejhumboldt@yahoo.com",
                password: "surfdemon1?",
                password_confirmation: "surfdemon1?")
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
       Profile.create!(user_id: 28,
                       first_name: "David",
                       last_name: "Janczyn",
                       blurb: "Just the way it goes")
        Profile.create!(user_id: 29,
          first_name: "Dave",
          last_name: "J",
          blurb: "I'm a whistle employee now")
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
