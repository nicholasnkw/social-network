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
  has_many :posts, :foreign_key => :author_id, :class_name => :post
  
  #likes
  has_many :likes, :foreign_key => :liker_id
  has_many :liked_things, :through => :likes, :source => :liker, dependent: :destroy
  
  #comments
  has_many :comments, :foreign_key => :author_id, :class_name => :comment
    
  # order by creation date
  # friends
  has_many :friendships
  has_many :friends, -> { where("friendships.status" => "accepted")}, :through => :friendships
  has_many :pending_friends, -> { where("friendships.status" => "pending").order(:created_at)}, :through => :friendships, :source => :friend
  has_many :requested_friends, -> { where("friendships.status" => "requested").order(:created_at)}, :through => :friendships, :source=> :friend
  
  
  def likes?(thing)
    likes.find_by(liked_id: thing.id)
  end
  
  
  
  # Omniauth Methods
  def self.from_omniauth(auth)
    if user = User.where(:email => auth.info.email).first()
      user
    else # Create a user with a stub password. 
      User.create!(:email => auth.info.email, :password => Devise.friendly_token[0,20]) 
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
