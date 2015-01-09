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
end