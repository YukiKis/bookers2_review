class MessagesController < ApplicationController
  def index
    @user = User.find(params[:id])
    @book_new = Book.new
    @message_users = User.all.map do |user|
      if @user.have_message?(user)
        user
      end
    end.compact
  end
  def show
  end
  
  def create
  end
  
  def destroy
  end
end
