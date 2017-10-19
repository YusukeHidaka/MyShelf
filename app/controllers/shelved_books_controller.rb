class ShelvedBooksController < ApplicationController
  def index
    @shelved_books = ShelvedBook.all
  end

  def edit
    @shelved_book = ShelvedBook.find(params[:id])
  end

  def destroy
    shelved_book = ShelvedBook.find(params[:id])
    shelved_book.destroy
    redirect_to shelf_users_path(current_user.id)
  end
end
