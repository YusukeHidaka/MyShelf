class OriginalBook < ApplicationRecord
  # after connecting api, it's gonna be change
  validates :isbn,
  # presence: true,
  uniqueness: true
  has_many :shelved_books, dependent: :destroy

  def self.count_shelved(t_book)
    ShelvedBook.where(original_book_id: t_book).count
  end

  def self.count_reviews(t_book)
    Review.with_shelved_book.search_with_original_book_id(t_book).count
  end
end
