class UsersController < ApplicationController
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    @book = Book.new
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
    redirect_to user_path
    @user = current_user
    else
    render :edit
    end
  end
  
  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :title, :body, :profile_image, :introduction)
  end