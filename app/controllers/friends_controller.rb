class FriendsController < ApplicationController
  
  def index
    @user = User.find(current_user.id)
  end
  
  def create
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    @friendship = Friendship.new(:user_id => @friend.id, :friend_id => @user.id, :status => 'pending')
    @inverse_friendship = Friendship.new(:user_id => @user.id, :friend_id => @friend.id, :status => 'requested')
    if @friendship.save && @inverse_friendship.save
      flash[:success] = "Request Sent"
      redirect_to users_path
    else
      flash[:error] = "Error"
      redirect_to users_path
    end
  end
  
  def update
    @user = current_user
    @friend = User.find(params[:friend_id])
    @friendship = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    @friendship_inverse = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)
    
    if @friendship.update_attributes(:status => 'accepted') && @friendship_inverse.update_attributes(:status => 'accepted')
      flash[:success] = 'Friend accepted!'
      redirect_to user_path(@user)
    else
      flash[:error] = "Error"
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = current_user
    @friend = User.find(params[:friend_id])
    @friendship = @user.friendships.find_by_friend_id(@friend.id).destroy
    @friendship_inverse = @friend.friendships.find_by_friend_id(@user.id).destroy
    redirect_to user_path(@user)
  end


 
end