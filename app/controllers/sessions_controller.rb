class SessionsController < ApplicationController
  def new
    puts notice
    puts params

  end

  def create
    @user = User.find_by_email(params[:email].downcase.strip)

    if (!@user)
      puts 'USER NOT FOUND'
      redirect_to '/login', notice: 'Invalid email or password'


    # If the user exists AND the password entered is correct.
    elsif @user == @user.authenticate_with_credentials(params[:email].downcase.strip, params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = @user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      @login_errors = "TEST LOGIN ERROR"
      redirect_to '/login', notice: 'Invalid email or password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', notice: 'Successfully logged out'
  end

end
