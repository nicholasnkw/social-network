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
    
    @pending_friends = Friendship.where(:friend_id => current_user.id)
    @pending_friends_profiles = []
    @pending_friends.each do |f|
      @pending_friends_profiles << Profile.find_by(:user_id => f.user_id)
    end
  end
  
end
