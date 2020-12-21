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
    @user = User.find(params[:id])
    @with_user = User.find(params[:with_user_id])
    @messages = @user.get_messages(@with_user).take(15)
    @message_new = Message.new
  end
  
  def create
    @user = User.find(params[:id])
    @with_user = User.find(params[:with_user_id])
    @message = Message.new(message_params)
    @message.from_user_id = @user.id
    @message.to_user_id = @with_user.id
    @message.save
    redirect_to message_user_path(@user, @with_user)
  end
  
  def destroy
    @user = User.find(params[:id])
    @message = Message.find(params[:message_id])
    @with_user = User.find(@message.to_user_id)
    @message.destroy
    redirect_to message_user_path(@user, @with_user)
  end
  
  private
    def message_params
      params.require(:message).permit(:message)
    end
end
