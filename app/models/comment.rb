class Comment < ApplicationRecord
  belongs_to :book_review
  belongs_to :comment, optional: true
  has_many :likes, dependent: :destroy
end
