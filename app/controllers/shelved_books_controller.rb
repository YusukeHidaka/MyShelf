class ShelvedBooksController < ApplicationController
  def index
  end

  def shelf
    @shelved_books = ShelvedBook.all
    # @shelved_books = ShelvedBook.all.where(user_id: params[:user_id])
  end

  def create
  end

  def params
    params.permit(:user_id)
  end
end
