class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  #profile
  has_one :profile, autosave: true
  accepts_nested_attributes_for :profile

  #posts
  has_many :posts, :foreign_key => :author_id, :class_name => :post, dependent: :destroy
  
  #likes
  has_many :likes, :foreign_key => :liker_id
  has_many :liked_things, :through => :likes, :source => :liker_id, dependent: :destroy
  
  #comments
  has_many :comments, :foreign_key => :author_id, :class_name => :post
    
  # order by creation date
  # friends
  has_many :friendships
  has_many :friends, -> { where("friendships.status" => "accepted")}, :through => :friendships
  has_many :pending_friends, -> { where("friendships.status" => "pending").order(:created_at)}, :through => :friendships, :source => :friend
  has_many :requested_friends, -> { where("friendships.status" => "requested").order(:created_at)}, :through => :friendships, :source=> :friend
  
  
  def likes?(thing)
    likes.find_by(liked_id: thing.id)
  end
end
