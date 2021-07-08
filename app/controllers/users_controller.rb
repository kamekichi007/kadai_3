class UsersController < ApplicationController
  def index
    @user = current_user
    @user.user_id = current_user.id
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    # @post_images = @user.post_images.page(params[:page]).reverse_order
    @books = @user.books
    @book = Book.new
  end

  def follows
    user = User.find(params[:id])
    @users = user.followeds
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
    flash[:notice] = "You have updated user successfully."
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
