class UsersController < ApplicationController

  # POST request
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup', notice:'Error! Please make sure all films are filled and a unique email is used. Password must also match and be 8 or more characters.'
  end

  end

  # GET request
  def new

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end





end
