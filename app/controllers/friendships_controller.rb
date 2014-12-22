class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], :status => "pending")
    if @friendship.save
      flash[:notice] = "Request Sent."
      redirect_to users_path
    else
      flash[:notice] = "Request Sent."
      redirect_to users_path
    end
  end
  
  def update
  end
  
  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end
end