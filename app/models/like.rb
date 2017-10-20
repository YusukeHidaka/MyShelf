class Like < ApplicationRecord
  belongs_to :review, counter_cache: :likes_count
  belongs_to :user
end
