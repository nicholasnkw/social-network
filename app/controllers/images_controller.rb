class ImagesController < ApplicationController 
  
  def create
    if Image.create(image: params[:image][:image], author_id: current_user.id)
      flash[:success] = "Image posted"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Oops error"
      render_user_path(current_user)
    end
  end
end