class UsersController < ApplicationController
  def new
    @user = User.new
    #def initialize(user={})
      #@name = user[:name]
      #@email = user[:email]
      #whole hash is the user[:] hash
      #params has multiple keys including user key, ex: utf or controller
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) #auxillary method instead of params[:user]
    if @user.save                 #allows us the use of strong parameters
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                        :password_confirmation)
  end
end
