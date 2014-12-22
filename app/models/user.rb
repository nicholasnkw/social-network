class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :profile, autosave: true
  accepts_nested_attributes_for :profile
  has_many :posts
    
  # order the records here
  has_many :friendships
  has_many :friends, -> { where("friendships.status" => "accepted")}, :through => :friendships
  has_many :pending_friends, -> { where("friendships.status" => "pending").order(:created_at)}, :through => :friendships, :source => :friend

end
