class Comment < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable
  has_many :likes, :as => :likeable
  
  validates :content, presence: true
end
