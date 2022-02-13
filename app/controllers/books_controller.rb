class BooksController < ApplicationController

 def index
   @book = Book.new
   @books = Book.all
   @user = current_user
 end

 def create
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
   @user = current_user
   @bookid = Book.find(params[:id])
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
   book = Book.find(params[:id])
   if book.update(book_params)
    redirect_to book_path(book.id)
    flash[:success] = 'You have updated book successfully.'
   else
    render :edit
   end
 end

 private

 def book_params
  params.require(:book).permit(:title, :body)
 end
 
end