class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def show  
    if params[:id] 
      @user = User.find(params[:id]) 
    else 
      @user = current_user
    end
    
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
