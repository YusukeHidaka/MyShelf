class RenamePublishDateColumnToOriginalBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :original_books, :publish_date, :publication_date
    add_column :original_books, :url, :text
  end
end
