namespace :db do
  desc "Populate the database"
  task populate: :environment do    
    [User, Profile, Friendship, Post, Comment, Like, Image].each(&:delete_all)
     make_users
     make_profiles
     make_friends
      make_posts
  end
  
  def make_users
    3.times do |n|
      email = "dave#{n}@gmail.com"
      password = "surfdemon11"
      User.create!(id: n,
                  email: email,
                  password: password,
                  password_confirmation: password)
    end
  end
    
    def make_profiles
      3.times do |n|
        user_id = n
        first_name = "David#{n}"
        last_name = "Janczyn"
        blurb = Faker::Hacker.say_something_smart
        Profile.create!(user_id: user_id,
                        first_name: first_name,
                        last_name: last_name,
                        blurb: blurb
          )
      end
    end
  
  def make_friends
    3.times do |n|
      user_id = n
      friend_id = n + 1 % 2
      status = "accepted"
      Friendship.create!(user_id: user_id, 
                         friend_id: friend_id,
                        status: status
        )
    end
      3.times do |n|
      user_id = n + 1 % 2
      friend_id = n 
      status = "accepted"
      Friendship.create!(user_id: user_id, 
                         friend_id: friend_id,
                        status: status
        )
    end
  end
  
  def make_posts 
    3.times do |n|
      description = Faker::Lorem.sentence
      author_id = n
      Post.create!(author_id: author_id,
                  description: description
        )
    end
  end
end
