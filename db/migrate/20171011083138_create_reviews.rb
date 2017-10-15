class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :shelved_book
      t.integer :shelved_book_id, null: false
      t.text  :content
      t.timestamps
    end
  end
end
