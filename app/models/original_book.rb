class OriginalBook < ApplicationRecord
  validates :isbn,
  presence: true,
  uniqueness: true
end
