class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :profile, autosave: true
  accepts_nested_attributes_for :profile
  has_many :posts
  
  has_many :friendships
  has_many :friends, :through => :friendships, 
                     :conditions => { "friendships.status" => "accepted"}
  has_many :pending_friends, :through => :friendships, 
                             :source => :friend, 
                             :conditions => {"friendships.status" => "pending"},
                             :order => :created_at
end
