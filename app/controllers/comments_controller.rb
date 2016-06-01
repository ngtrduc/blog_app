class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
  	@comment = Comment.new(comment_params)
  	@comment.user_id = current_user.id
  	if @comment.save
  		redirect_back_or current_user
  	else
  		redirect_back_or current_user
  	end
  end

  def destroy
  end

  private

  def comment_params
  	params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
