class StaticPagesController < ApplicationController
  def home
  	if logged_in?
  		@post = current_user.posts.build
  		@comment = current_user.comments.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	end
  end

  def help
  end

  def search
  end
end