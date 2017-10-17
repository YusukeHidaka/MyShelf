class ShelvedBooksController < ApplicationController
  def index
    @shelved_books = ShelvedBook.all
  end
end
