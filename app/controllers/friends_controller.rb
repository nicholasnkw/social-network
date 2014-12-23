class FriendsController < ApplicationController
  
  def index
    @user = User.find(current_user.id)
  end
  
  def create
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    @friendship = Friendship.create(:user_id => @friend.id, :friend_id => @user.id, :status => 'pending')
    @inverse_friendship = Friendship.create(:user_id => @user.id, :friend_id => @friend.id, :status => 'requested')
    if @friendship.save && @inverse_friendship.save
      flash[:success] = "Request Sent"
      redirect_to users_path
    else
      flash[:error] = "Error"
      redirect_to users_path
    end
  end
  
  def update
    @user = User.find(current_user)
    @friend = User.find(params[:id])
    params[:friendship] = {user_id => @user.id, :friend_id => @friend.id, :status => 'accepted'}
    params[:friendship_inverse] = {user_id => @friend.id, :friend_id => user.id, :status => 'accepted'}
    @friendship = Friendship.find_by(user_id: @user.id, friend_id: @friend.id)
    @friendship_inverse = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)
    if friendship.update_attributes(params[:friendship]) && friendship.update_attributes(params[:friendship_inverse])
      flash[:notice] = 'Friend sucessfully accepted!'
      redirect_to user_path
    else
      redirect_to user_path
    end
  end

  def destroy
    @user = User.find(params[:friend_id])
    @friend = current_user
    @friendship = @user.friendships.find_by_friend_id(@friend.id).destroy
    @friendship_inverse = @friend.friendships.find_by_friend_id(@user.id).destroy
    redirect_to user_path(current_user)
  end


 
end