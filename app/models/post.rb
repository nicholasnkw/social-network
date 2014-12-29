class Post < ActiveRecord::Base
  
  # user
  belongs_to :author, :class_name => "User"
  
  # likes
  has_many :likes, :foreign_key => "liked_id"
  has_many :likers, :through => :likes
  
  # comments
  has_many :comments, dependent: :destroy;
  
  validates :description, presence: true
end
