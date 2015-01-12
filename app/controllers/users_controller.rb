class UsersController < ApplicationController
  
  # make David friends with every new user
  # after_create :add_david_to_friends
  #Just call profile.all here
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
    @profile = @user.profile
    @posts = Post.where(author_id: @user)
    @images = Image.where(author_id: @user)
    @feed = (@posts + @images).sort_by(&:created_at)
    @friends = current_user.friends.includes(:profile)
  end
end
