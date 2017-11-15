class RenameShelvedAndReviewColumnToCorrect < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :review_id, :book_review_id
    rename_column :likes, :review_id, :book_review_id
    rename_column :original_book_rankings, :shelved_amount, :colored_amount
    rename_column :book_reviews, :shelved_book_id, :colored_book_id
  end
end
