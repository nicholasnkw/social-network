class Like < ActiveRecord::Base
  belongs_to :liked, :class_name => "Post"
  belongs_to :liker, :class_name => "User"
end
