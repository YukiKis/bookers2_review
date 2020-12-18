class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
    @book_new = Book.new()
  end

  def show
    @book = Book.find(params[:id])
    @usre = @book.user
    @book_new = Book.new()
  end

  def edit
  end
end
