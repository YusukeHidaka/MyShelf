class Review < ApplicationRecord
  belongs_to :user
  # belongs_to :shelved_book
  # has_many :likes
  # has_many :comments
end
