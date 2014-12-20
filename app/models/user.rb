class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :profile, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :profile
  has_many :posts
  has_many :friends, :through => :friendship, :conditions => { "friendships.status" => "accepted"}
  has_many :pending_friends, :through => :friendship, :source => :friend, :conditions => {"friendships.status" => "pending"}, :order => :created_at
  has_many :friendship, dependent: :destroy
end
