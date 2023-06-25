class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if  @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
   else
     @books = Book.all
     render :index
   end
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
    @users = User.all
  end

   def show
    @newbook = Book.new
    
     @book = Book.find(params[:id])
     @user = @book.user
   end

   def edit
   book = Book.find(params[:id])
  unless book.user.id == current_user.id
    redirect_to books_path
  end
  
     @user = current_user
     @book = Book.find(params[:id])
   end

   def update
    # book = Book.find(params[:id])
    # unless book.user.id == current_user.id   
    # redirect_to books_path
    # end
     
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
   end

  def destroy
    @user = current_user
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

 private
 def book_params
    params.require(:book).permit(:title, :body, :name, :profile_image, :introduction)
 end

end
