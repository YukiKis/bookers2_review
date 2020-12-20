class CommentsController < ApplicationController
  def create 
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book = @book
    if @comment.save
      redirect_to book_path(@book)
    else
      @user = @book.user
      render "books/show"
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    Comment.find(params[:id]).destroy
  end
  
  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
