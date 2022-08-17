class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:index,:show,:edit,:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to user_path(current_user.id)
    else
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

end
