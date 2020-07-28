class UsersController < ApplicationController

  # POST request
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
  end

  end

  # GET request
  def new

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email.downcase.strip, :password, :password_confirmation)
  end





end
