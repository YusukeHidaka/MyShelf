class OriginalBookRankingsController < ApplicationController
  def index
    @user = current_user
    @original_books = OriginalBook.joins(:original_book_ranking).includes(:original_book_ranking).order("original_book_rankings.shelved_amount DESC")
  end
end
