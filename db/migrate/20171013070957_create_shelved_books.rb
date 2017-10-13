class CreateShelvedBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :shelved_books do |t|
      t.integer :user_id
      t.integer :original_book_id
      t.integer :status
      t.timestamps
    end
  end
end
