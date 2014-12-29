class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment Posted!"
      redirect_to session.delete(:return_to)
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:author_id, :content, :post_id)
  end
end