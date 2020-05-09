class UsersController < ApplicationController

    before_action :authenticate_user!

    before_action :ensure_current_user, only:[:edit]

    
  def show
  	@user = User.find(params[:id])
    @book = Book.new
  	@books = @user.books.reverse_order

  end

  def index
    @user = current_user
    @book = Book.new
  	@users = User.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
  if  user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(current_user)
  else
    @user = user
    render "edit"
  end
  end

  protected
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

    def ensure_current_user
      @user = User.find(params[:id])
      if current_user.id !=  @user.id
        redirect_to user_path(current_user)
      end
    end
end
