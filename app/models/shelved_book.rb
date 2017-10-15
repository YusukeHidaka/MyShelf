class ShelvedBook < ApplicationRecord
  belongs_to :original_book, optional: true
  enum status: { tsundoku: 0, read: 1, wish: 2 }

  has_one :review

  def update_status_amount(original_book)
    target_book_reviews = ShelvedBook.where(original_book_id: original_book.id)
    original_book.update_attribute(:read_amount, target_book_reviews.where(status: "read").count)
    original_book.update_attribute(:tsundoku_amount, target_book_reviews.where(status: "tsundoku").count)
    original_book.update_attribute(:wish_amount, target_book_reviews.where(status: "wish").count)
  end
end
