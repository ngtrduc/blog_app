class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
  	@comment = Comment.new(comment_params)
  	@comment.user_id = current_user.id
    @post = Post.find(@comment.post_id)
    noti = Noti.new
    noti.noti_type = 1
    noti.post_id = @comment.post_id
    noti.user_id = @post.user_id
    noti.status = true
    if @comment.save && noti.save
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private

  def comment_params
  	params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
