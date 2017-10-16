class ShelvedBooksController < ApplicationController
  def index
  end

  def original_book_title
    self.original_book.title
  end
end
