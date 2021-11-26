class BooksController < ApplicationController
  before_action :authenticate_user!


  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to(book_path(@book.id))
    else
      @books = Book.all
      @user = current_user
      render :index
      end
  end

  def index
    @book = Book.new
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
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def books_params
    params.require(:book).permit(:title,:body)
  end

end