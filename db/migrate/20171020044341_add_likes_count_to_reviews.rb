class AddLikesCountToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :likes_count, :integer
  end
end
