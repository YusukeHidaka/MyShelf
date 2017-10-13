class ShelvedBook < ApplicationRecord
  belongs_to :original_book, optional: true
  enum status: { tsundoku: 0, read: 1 }

  has_one :review
end
