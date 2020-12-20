class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    current_user.favorites.create(book: @book)
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    current_user.favorites.find_by(book: @book).destroy
  end

end
