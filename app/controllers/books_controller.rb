class BooksController < ApplicationController
 
 before_action :correct_user, only: [:edit, :update]

 def index
   @book = Book.new
   @books = Book.all
   @user = current_user
 end

 def create
   @books = Book.all
   @user = current_user
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
    flash[:success] = 'You have created book successfully.'
    redirect_to book_path(@book.id)
   else
    render :index
   end
 end

 def show
   @bookid = Book.find(params[:id])
   @user = @bookid.user
   @book = Book.new
 end

 def destroy
   bookid = Book.find(params[:id])
   bookid.delete
   redirect_to books_path
 end

 def edit
   @book = Book.find(params[:id])
 end

 def update
   @book = Book.find(params[:id])
   if @book.update(book_params)
    redirect_to book_path(@book.id)
    flash[:success] = 'You have updated book successfully.'
   else
    render :edit
   end
 end

 private

 def book_params
  params.require(:book).permit(:title, :body)
 end
 
 def correct_user
  @book = Book.find(params[:id])
  @user = @book.user
  redirect_to(books_path) unless @user == current_user
 end
 
end