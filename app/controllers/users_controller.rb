class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    @book_new = current_user.books.new()
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user == current_user
      if @user.update(user_params)
        redirect_to user_path(@user)
      else
        render :edit
      end
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :introduction)
    end
end
