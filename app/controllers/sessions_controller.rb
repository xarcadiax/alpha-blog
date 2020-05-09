class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) #if user is found & password is correct 
      session[:user_id] = user.id #allows user to remain signed in
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "There was somthing wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
  
end