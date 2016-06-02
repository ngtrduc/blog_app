class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def show
		@post = Post.find(params[:id])
		@comment = current_user.comments.build if logged_in? && current_user.following?(@post.user)
	end
	def create
		@post = current_user.posts.build(posts_params)
		if @post.save
			flash[:success] = "You post have been created!!"
			unless current_user.followers.nil?
				current_user.followers.each do |user|
					post_id = @post.id
					create_noti_for user, post_id
				end
			end
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
		@post.destroy
		flash[:success] = "post deleted"
		redirect_to request.referrer || root_url
	end

	private 

	def create_noti_for user, post_id
		noti = Noti.new
		noti.noti_type = 2
		noti.status = true
		noti.post_id = post_id
		noti.user_id = user.id
		noti.save
	end
	def posts_params
		params.require(:post).permit(:title,:content)
	end

	def correct_user
		@post = current_user.posts.find_by(id: params[:id])
		redirect_to root_url if @post.nil?
	end
end
