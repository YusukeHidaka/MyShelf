class UsersController < ApplicationController
  def index
     @users = User.all
  end

  def show
     @user = User.find(params[:id])
     @shelved_books = ShelvedBook.all.where(user_id: params[:id]).order("updated_at DESC")
  end

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to user_path, flash: {notice: 'プロフィールを更新しました'}
  end

  def reviews
    @user = User.find(params[:id])
    @reviews = Review.with_user.search_with_user_id(params[:id]).order("updated_at DESC")
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
    puts "======================"
    puts "======================"
    puts params
    puts "======================"
    puts "======================"
    @users = User.where("name LIKE :keyword OR email LIKE :keyword", keyword: "%#{params[:keyword]}%")
    @users.each do |user|
      @user = user
    end
  end

  private

  def update_params
    params.require(:user).permit(:name, :description, :image)
  end

  def use_before_action?
    true
  end
end
