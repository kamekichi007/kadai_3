class BooksController < ApplicationController
  def top
  end

  def index
    # @users = User.find(params[:id])
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
    flash[:notice] = "You have created book successfully."
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    else
      redirect_to books_path
    end
    flash[:notice] = "You have updated book successfully."
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

   def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
   end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
