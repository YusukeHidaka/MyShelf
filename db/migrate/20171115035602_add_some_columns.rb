class AddSomeColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :comment_id, :integer
    add_column :likes, :comment_id, :integer
    add_column :original_books, :quit_amount, :integer
    add_column :book_reviews, :comments_count, :integer
  end
end
