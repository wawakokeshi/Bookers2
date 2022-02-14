class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id).includes(:user).order("created_at DESC")
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.new
    user = User.find(params[:id])
    if user.update(user_params)
     flash[:success] = 'You have updated user successfully.'
     redirect_to user_path(user.id)
    else
     render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end