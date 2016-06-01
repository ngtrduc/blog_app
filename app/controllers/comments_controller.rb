class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
  	@comment = Comment.new(comment_params)
  	@comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
  	params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
