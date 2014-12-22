class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], :status => "pending")
    if @friendship.save
      flash[:notice] = "Request Sent."
      redirect_to users_path
    else
      flash[:notice] = "Error"
      redirect_to users_path
    end
  end
  
  def update
    @friendship = current_user.friendships.find(params[:update])
    @friendship_inverse = current_user.friendships.new(:user_id => current_user.id, :friend_id => params[:friend_id], :status => "accepted")
    if @friendship.update(:status => "accepted") && @friendship_inverse.save
      # update this to be the friends name
      flash[:notice] = "Friend Added"
      redirect_to users_path
    else
      flash[:notice] = "Error"
      redirect_to users_path
    end
  end
  
  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end
end