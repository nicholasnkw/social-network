class PostsController < ApplicationController
  #Do a where and or query here
  def index
    @posts = Post.order('created_at DESC')
    @images = Image.order('created_at DESC')
    @combine = (@posts + @images).sort_by(&:created_at)
    @feed = []
    @combine.each do |p|
      if p.author == current_user || p.author.friends.include?(current_user)      
        @feed << p
      end
    end       
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