class BooksController < ApplicationController
  before_action :authenticate_user!, only:[:new,:index,:show,:edit,:update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @book_show = Book.find(params[:id])
    @user = @book_show.user
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @book =Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to book_path
    else
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
      else
        render action: :edit
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    else
      @book.destroy
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
