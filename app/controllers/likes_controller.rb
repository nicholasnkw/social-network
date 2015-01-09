class LikesController < ApplicationController
  def create
    @like = Like.new(:liker_id => current_user.id, likeable_id: params[:liked_id])   
    if @like.save
      flash[:success] = "Liked!"
      redirect_to session.delete(:return_to)
    else
      flash.now[:error] = "Error"
      redirect_to session.delete(:return_to)
    end
  end
  def destroy
    @like = current_user.likes.find_by(:likeable_id => params[:liked_id], :likeable_type => params[:likeable_type])
    if @like.destroy
      redirect_to session.delete(:return_to)
    end
  end
end