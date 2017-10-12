class OriginalBooksController < ApplicationController
  def index
    @original_books = OriginalBook.all
  end
  private

  def original_book_params
    params.require(:original_book).permit(:title, :author, :description, :image_url, :publisher, :isbn, :publish_date, :read_amount, :tsundoku_amount)
  end
end
