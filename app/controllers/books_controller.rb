class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Books.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to books_path
    else
      @books=Book.all
      @user =@book.user
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def edit
    if Book.find(params[:id]).user_id == current_user.id
      @book = Book.find(params[:id])
    end
  end

  def update
    @book =Book.find(params[:id])
    if @book.updata(book_params)
      flash[:notice] = "Book was successfully updated!"
      redirect_to(book_path(@book.id))
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice]="Book was successfully destroyed."
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
