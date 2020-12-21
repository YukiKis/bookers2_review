class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
    @book_new = Book.new()
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new()
    @comment = Comment.new()
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You successfully update!"
    else
      render :edit
    end
  end
  
  def create
    path = request.referer
    @book = current_user.books.new(book_params)
    if @book.save
     redirect_to book_path(@book), notice: "You successfully made!"
    else
      # need object depending on the pagegi
      render path
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: "You successfully deleted"
  end
  
  def search
    @user = current_user
    @book_new = Book.new
    keyword = search_params[:keyword]
    how = search_params[:how]
    case how
    when "前方検索"
      @books = Book.search_forward(keyword)
      render :index
    when "後方検索"
      @books = Book.search_back(keyword)
      render :index
    when "全検索"
      @books = Book.search_all(keyword)
      render :index
    else
      flash.now[:notice] = "検索方法を選択してください"
      @books = Book.all
      render :index
    end
  end
  
  private
    def book_params
      params.require(:book).permit(:title, :opinion)
    end
    
    def search_params
      params.require(:search).permit(:how, :keyword)
    end
end
