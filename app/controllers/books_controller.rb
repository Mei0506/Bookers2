class BooksController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
    redirect_to books_path
  end
  
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to user_path(current_user.id)
    else
      flash.now[:notice] = "Book creation failed."
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @users = @book.user
    @new_book = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    if book.update
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      flash.now[:notice] = "Book update failed."
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
     redirect_to books_path
    end
  end

end
