class CreateShelvedBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :shelved_books do |t|
      t.integer :user_id, null: false
      t.integer :original_book_id, null: false
      t.integer :status, null: false, :default => 0
      t.timestamps
    end
  end
end
