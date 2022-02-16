class BooksController < ApplicationController
  def new
    @nbook = Book.new
  end

  def create
    @user = current_user
    @nbook = Book.new(book_params)
    @nbook.user_id = current_user.id
    if @nbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@nbook.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @nbook = Book.new
    # @book = Book.find(params[:id])

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @nbook = Book.new

    # @user = current_user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
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
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
