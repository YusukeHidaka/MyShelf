class CreateOriginalBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :original_books do |t|
      t.string :title
      t.string :author
      t.text :image_url
      t.string :publisher
      t.string :isbn
      t.date :publish_date
      t.integer :read_amount
      t.integer :reading_amount
      t.integer :tsundoku_amount
      t.integer :wish_amount

      t.timestamps
    end
  end
end
