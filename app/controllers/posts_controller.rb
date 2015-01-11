class PostsController < ApplicationController
  def index
    @posts = Post.where(:author_id => current_user).or(Post.author.friends.include?(current_user))
    @images = Image.where(:author_id => current_user)
    @feed = (@posts + @images)     
  end
  def create
    if Post.create(description: params[:post][:description], image: params[:post][:image], author_id: current_user.id)
      flash[:success] = "Posted"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Post failed"
      render user_path(current_user)
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update 
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to session.delete(:return_to)
    else
      flash.now[:error] = "error" 
      render edit_post_path(params[:id])
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:error] = "Post destroyed"
      redirect_to session.delete(:return_to)
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:description, :image)
  end
end