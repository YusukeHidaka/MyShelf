class UsersController < ApplicationController
  def index
     @users = User.all
  end

  def show
     @user = User.find(params[:id])
     @o_reviews = Review.with_user.search_with_user_id(params[:id])
     @reviews = @o_reviews.page(params[:page]).per(10).order("updated_at DESC")
  end

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to user_path, flash: {notice: 'プロフィールを更新しました'}
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def search
    @users = User.where("name LIKE :keyword OR email LIKE :keyword", keyword: "%#{params[:keyword]}%")
    @users.each do |user|
      @user = user
    end
  end

  def shelf
    @user = User.find(params[:id])
    unless params[:set_status].present?
      @shelved_books = ShelvedBook.where(user_id: params[:id]).page(params[:page]).per(12).order("updated_at DESC")
    else
      @shelved_books = ShelvedBook.where(user_id: params[:id], status: params[:set_status]).page(params[:page]).per(12).order("updated_at DESC")
    end
  end

  private

  def update_params
    params.require(:user).permit(:name, :description, :email, :image)
  end

  def use_before_action?
    true
  end
end
