class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  #omniauth
  has_many :authentications
  
  #profile
  has_one :profile, autosave: true
  accepts_nested_attributes_for :profile

  #posts
  has_many :posts, :foreign_key => :author_id, dependent: :destroy
  
  #post-images
  has_many :images, :foreign_key => :author_id, dependent: :destroy
  
  #likes
  has_many :likes, :as => :likeable
  
  #comments
  has_many :comments, :foreign_key => :author_id, dependent: :destroy
    
  # order by creation date
  # friends
  has_many :friendships
  has_many :friends, -> { where("friendships.status" => "accepted")}, :through => :friendships
  has_many :pending_friends, -> { where("friendships.status" => "pending").order(:created_at)}, :through => :friendships, :source => :friend
  has_many :requested_friends, -> { where("friendships.status" => "requested").order(:created_at)}, :through => :friendships, :source=> :friend
  

  
  def likes?(thing)
    Like.find_by(likeable_id: thing.id)
  end
  
  def feed
    @posts = Post.where("author_id in (?) OR author_id = ?", friend_ids, self).includes(:likes, author: [:profile], comments: [author: [:profile]])
    @images = Post.where("author_id in (?) OR author_id = ?", friend_ids, self).includes(:likes, author: [:profile], comments: [author: [:profile]])
    @feed = (@posts + @images).sort_by(&:created_at).uniq
  end

  
  # Omniauth Methods
  def self.from_omniauth(auth)
    if user = User.where(:email => auth.info.email).first()
       user
    else # Create a user with a stub password and a profile
      u = User.create!(:email => auth.info.email, :password => Devise.friendly_token[0,20])
      Profile.create!(:user_id => u.id, :first_name => auth.info.first_name, :last_name => auth.info.last_name, :blurb => Faker::Hacker.say_something_smart )  
      UserMailer.welcome_email(u).deliver unless u.invalid?
      u
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
