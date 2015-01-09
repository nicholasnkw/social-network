class CommentsController < ApplicationController
  before_filter :find_commented, :only => [:create]
  def new
    @comment = Comment.new
  end
  
  def create
    if @commented.comments.create(:author_id => current_user.id, :content => params[:comment][:content])
      flash[:success] = "Comment Posted!"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Comment not posted"
      render new_comment
    end
  end
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:error] = "Comment destroyed"
      redirect_to session.delete(:return_to)
    end
  end
  #perhaps whitelist before this constantize call
  private
  def find_commented
    klass = params[:commentable_type].capitalize.constantize
    @commented = klass.find(params[:commentable_id])
  end
  def comment_params
    params.require(:comment).permit(:author_id, :content, :commentable_type, :commentable_id) 
  end
end