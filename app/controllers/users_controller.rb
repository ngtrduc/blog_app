class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]

  def show
    @comment = current_user.comments.build if logged_in?
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end 
  def new
  	@user = User.new
  end
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def create
  	@user = User.new user_params
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end 
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private 
  #permit user's params for only name, email, password and password_comfirmation attribute
  def user_params
	  params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
  #check correct user for action 
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
