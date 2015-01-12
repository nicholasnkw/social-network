class ImagesController < ApplicationController  
  
  def create
    @image = Image.new(image: params[:image][:image], author_id: current_user.id)
    if @image.save
      flash[:success] = "Image posted"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Oops error"
      render_user_path(current_user)
    end
  end
  
  def destroy
    @image = Image.find(params[:id])
    if @image.destroy
      flash[:error] = "Image destroyed"
      redirect_to session.delete(:return_to)
    end
  end
end