class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  has_many :likes, :foreign_key => "liked_id"
  has_many :likers, :through => :likes
end
