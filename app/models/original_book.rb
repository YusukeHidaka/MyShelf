class OriginalBook < ApplicationRecord
  # after connecting api, it's gonna be change
  # validates :isbn,
  # presence: true,
  # uniqueness: true
  has_many :shelved_books, dependent: :destroy
end
