class Like < ApplicationRecord
  belongs_to :book_review, optional: true, counter_cache: :likes_count
  belongs_to :user
  belongs_to :comment, optional: true, counter_cache: :comments_count
  validates :book_review_id, uniqueness: { scope: :user_id}
  validates :comment_id, uniqueness: { scope: :user_id}
end
