class BooksController < ApplicationController
  before_action :authenticate_user!

   before_action :authenticate_user!


  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully posted!"
      redirect_to(book_path(@book.id))
    else
      err_msg = "error! Failed to update data.\n"
      @book.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end

      flash[:alert] = err_msg
      redirect_back(fallback_location: root_path)
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
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      flash[:notice] = "Book was successfully updated!"
      redirect_to(book_path(@book.id))
    else
      err_msg = "error! Failed to update data.\n"
      @book.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end

      flash[:alert] = err_msg
      render(action: "edit")
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to(books_path)
  end

  private
  def books_params
    params.require(:book).permit(:title,:body)
  end

end