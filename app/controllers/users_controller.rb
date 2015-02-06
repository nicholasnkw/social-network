class UsersController < ApplicationController
  
  # make David friends with every new user
  # after_create :add_david_to_friends
  def index
    @users = User.includes(:profile)
  end
  
  def show  
    @post = Post.new
    @image = Image.new
    if params[:id] 
      @user = User.find(params[:id])
      # .includes(:profile)
    else 
      @user = current_user
    end
    @posts = Post.where(author_id: @user).includes(:likes, author: [:profile], comments: [author: [:profile]])
    @images = Image.where(author_id: @user).includes(:likes, author: [:profile], comments: [author: [:profile]])
    @feed = (@posts + @images).sort_by(&:created_at).uniq
    @friends = current_user.friends.includes(:profile)
  end
  
end
