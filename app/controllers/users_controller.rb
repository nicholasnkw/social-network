class UsersController < ApplicationController
  
  # make David friends with every new user
  # after_create :add_david_to_friends
  #Just call profile.all here
  def index
    @users = User.all
    @users_profiles = [];
    @users.each do |u|
      @users_profiles << u.profile
    end
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
    
    @friends_profiles = []
    @friends.each do |f|
      @friends_profiles << f.profile
    end
    
    @pending_friends = current_user.pending_friends
    @pending_friends_profiles = []
    @pending_friends.each do |p|
      @pending_friends_profiles << p.profile
    end
  end
end
