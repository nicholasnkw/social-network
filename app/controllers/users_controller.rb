class UsersController < ApplicationController
  
  # make David friends with every new user
  # after_create :add_david_to_friends
  #Just call profile.all here
  def index
    @users = User.all
  end
  
  def show  
    @post = Post.new
    @image = Image.new
    if params[:id] 
      @user = User.find(params[:id]) 
    else 
      @user = current_user
    end 
    @posts = Post.where(author_id: @user).order('created_at DESC')
    @images = Image.where(author_id: @user).order('created_at DESC')
    @feed = (@posts + @images).sort_by(&:created_at)
    @profile = @user.profile
    @friends = current_user.friends
  end
end
