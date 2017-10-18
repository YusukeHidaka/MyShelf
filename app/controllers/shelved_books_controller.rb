class ShelvedBooksController < ApplicationController
  def index
    @shelved_books = ShelvedBook.all
  end

  def edit
    @shelved_book = ShelvedBook.find(params[:id])
  end
end
