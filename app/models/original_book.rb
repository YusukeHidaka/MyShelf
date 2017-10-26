class OriginalBook < ApplicationRecord
  # after connecting api, it's gonna be change
  validates :isbn,
  # presence: true,
  uniqueness: true
  has_many :shelved_books, dependent: :destroy

  def self.count_shelved(t_book)
    original_book = OriginalBook.find_by(isbn: t_book)
    if original_book.present?
      ShelvedBook.where(original_book_id: original_book.id).count
    else
      return 0
    end
  end

  def self.count_reviews(t_book)
    original_book = OriginalBook.find_by(isbn: t_book)
    if original_book.present?
      Review.with_shelved_book.search_with_original_book_id(original_book.id).count
    else
      return 0
    end
  end
end
