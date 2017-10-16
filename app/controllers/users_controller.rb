class UsersController < ApplicationController
  def index
     @users = User.all
  end

  def show
     @user = User.find(params[:id])
  end

  def edit
  end

  def update
    current_user.update(update_params)
  end

  def shelf
    @shelved_books = ShelvedBook.all.where(user_id: params[:id])
  end

  private

  def update_params
    params.require(:user).permit(:name, :description, :image)
  end
end
