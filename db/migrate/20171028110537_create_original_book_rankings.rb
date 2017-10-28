class CreateOriginalBookRankings < ActiveRecord::Migration[5.1]
  def change
    create_table :original_book_rankings do |t|
      t.integer :original_book_id, null: false
      t.integer :shelved_amount, null: false, :default => 0
      t.timestamps
    end
  end
end
