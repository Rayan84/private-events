class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def logged_in
    @user = User.find_by(username: params[:username])
    if @user
      session[:id] = @user.id
      session[:username] = @user.username
      redirect_to @user
    else
      render :sign_in
    end
  end

  private
    def user_params
      params.require(:user).permit(:username)
    end

end
