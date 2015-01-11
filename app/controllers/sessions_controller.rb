class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #log into user and redirect to users home page
    else
      #Create an error message
      flash.now[:danger] = "Invalid email/password combonation" #not quite right
      render 'new'
    end
  end

  def destroy
  end
end
