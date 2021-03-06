class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
			params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to user
      #log into user and redirect to users home page
    else
      #Create an error message
      flash.now[:danger] = "Invalid email/password combonation" #not quite right
      render 'new'
    end
  end

  def destroy
		log_out if logged_in?
    redirect_to root_url
  end
end
