class LikesController < ApplicationController
  def create
    @like = Like.new(:liker_id => current_user.id, liked_id: params[:post_id])   
    if @like.save
      flash[:success] = "Liked!"
      redirect_to current_user
    else
      flash.now[:error] = "Error"
      render users_path
    end
  end
  def destroy
    @like = current_user.likes.find_by(:liked_id => params[:liked_id])
    if @like.destroy
      redirect_to(current_user)
    end
  end
end