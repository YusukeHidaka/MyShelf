class ColoredBook < ApplicationRecord
  belongs_to :original_book, dependent:   :destroy
  belongs_to :user, dependent:   :destroy
  has_one :book_review, dependent: :destroy
  enum status: { tsundoku: 0, read: 1, wish: 2 }
  # 3: quit

  def update_status_amount(original_book)
    target_book_reviews = ColoredBook.where(original_book_id: original_book.id)
    original_book.update_attributes!(:read_amount, target_book_reviews.where(status: "read").count)
    original_book.update_attributes!(:tsundoku_amount, target_book_reviews.where(status: "tsundoku").count)
    original_book.update_attributes!(:wish_amount, target_book_reviews.where(status: "wish").count)
    # original_book.update_attributes!(:quit_amount, target_book_reviews.where(status: "wish").count)
  end
end
