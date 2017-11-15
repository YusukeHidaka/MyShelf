class Like < ApplicationRecord
  belongs_to :book_review, optional: true, counter_cache: :likes_count
  belongs_to :user
  belongs_to :comment, optional: true, counter_cache: :comments_count
end
