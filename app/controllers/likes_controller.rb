class LikesController < ApplicationController
  before_filter :find_liked, :only => [:create]
  
  def create
    if @liked.likes.create(:liker_id => current_user.id)
      flash[:success] = "Liked!"
      redirect_to session.delete(:return_to)
    else
      flash.now[:error] = "Error"
      redirect_to session.delete(:return_to)
    end
  end
  def destroy
    
    @like = Like.where(:likeable_id => params[:likeable_id]).where(:liker_id => current_user).first
    if @like.destroy
      redirect_to session.delete(:return_to)
    end
  end
  
  private
  def find_liked
    klass = params[:likeable_type].capitalize.constantize
    @liked = klass.find(params[:likeable_id])
  end
end