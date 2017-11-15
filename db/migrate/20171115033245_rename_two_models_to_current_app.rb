class RenameTwoModelsToCurrentApp < ActiveRecord::Migration[5.1]
  def change
    rename_table :reviews, :book_reviews
    rename_table :shelved_books, :colored_books
  end
end
