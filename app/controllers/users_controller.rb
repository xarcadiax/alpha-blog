class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy] #checks if a user is logged in
  before_action :require_same_user, only: [:edit, :update, :destroy] #checks if a user is actoning onw items
  
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up!"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user #prevents admin from being logged out when deleting another users account 
    flash[:notice] = "You have successfully deleted your account all associated articles"
    redirect_to articles_path
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
    flash[:notice] = "Your account was successfully updated"
    redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own user account"
      redirect_to @user
    end
  end
  
end