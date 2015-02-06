class Post < ActiveRecord::Base
  
  # user
  belongs_to :author, :class_name => "User"
  
  # likes
  has_many :likes, :as => :likeable
  
  # comments
  has_many :comments, :as => :commentable, dependent: :destroy
  
end
