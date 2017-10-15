class CreateOriginalBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :original_books do |t|
      t.string :title
      t.string :author
      t.text :image_url
      t.string :publisher
      t.date :publish_date
      t.string :isbn
      t.integer :read_amount, null: false, :default => 0
      t.integer :tsundoku_amount, null: false, :default => 0
      t.integer :wish_amount, null: false, :default => 0

      t.timestamps
    end
  end
end
