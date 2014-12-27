class PostsController < ApplicationController
  # Put the form right on the profile page.
  def index
    
  end
  def create
    if Post.create(description: params[:post][:description], author_id: current_user.id)
      flash[:success] = "Posted"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Post failed"
      render user_path(current_user)
    end
  end
  def destroy
  end
end