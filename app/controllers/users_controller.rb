class UsersController < ApplicationController
  
  # make David friends with every new user
  # after_create :add_david_to_friends
  #Just call profile.all here
  def index
    @users = User.all
  end
  
  def show  
    @post = Post.new
    if params[:id] 
      @user = User.find(params[:id]) 
    else 
      @user = current_user
    end 
    @posts = Post.where(author_id: @user)
    @profile = @user.profile
    @friends = current_user.friends
  end
end
