class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		@post = current_user.posts.build
  		@comment = current_user.comments.build
  		@feed_items = current_user.feed.paginate(page: params[:page],  :per_page => 6)
  	end
  end

  def help
  end

  def search
  	@comment = current_user.comments.build if logged_in?
  	#search by post's tittle
  	if params[:search_by] == '1'
    	@posts = Post.where("title like ?", "%#{params[:search]}%").paginate(page: params[:page], :per_page => 6)
    	@users = nil
    end
    #search by user's name
    if params[:search_by] == '2'
    	@users=  User.where("name like ?", "%#{params[:search]}%").paginate(page: params[:page], :per_page => 6)
    	@posts=nil
    end
  end
end