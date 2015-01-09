class RemovePostIdAddCommentableToLikes < ActiveRecord::Migration
  def change
    remove_column :likes, :liked_id
    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string
  end
end
