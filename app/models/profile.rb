class Profile < ActiveRecord::Base
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :blurb, presence: true
  belongs_to :user
end
