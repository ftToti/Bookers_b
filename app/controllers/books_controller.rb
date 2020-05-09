class BooksController < ApplicationController

	before_action :authenticate_user!

	before_action :ensure_current_user, only:[:edit]


	def index
		@book = Book.new
		@books = Book.all.reverse_order
        @user = current_user
	end

	def create
		book = Book.new(book_params)
		book.user_id = current_user.id
      if book.save
      	flash[:notice] = "You have creatad book successfully."
		redirect_to book_path(book.id)
      else
		@book = book
		@books = Book.all.reverse_order
		@user = current_user
		render 'index'
      end
    end

	def show
		@book = Book.new
		@bookf = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])
	end


	def update
		book = Book.find(params[:id])
	  if book.update(book_params)
	  	flash[:notice] = "You have updated book successfully."
		redirect_to book_path(book.id)
	  else
	  	@book = book
	  	render "edit"
	  end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	protected
    def book_params
    	params.require(:book).permit(:title, :body)
    end

    def ensure_current_user
      @book = Book.find(params[:id])
      if current_user.id !=  @book.user.id
        redirect_to books_path
      end
    end
end
