class Image < ActiveRecord::Base
  belongs_to :author, :class_name => "User"
  
  has_many :comments, :as => :commentable, dependent: :destroy
  
  has_many :likes, :as => :likeable
  
  has_attached_file :image, :styles => { :medium => "400x400>", :thumb => "50x50>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
