module OriginalBooksHelper
  def set_book(book, status)
    {original_book:{author: book.author, title: book.title, publisher: book.publisher, publish_date: book.publication_date, isbn: book.isbn, image_url: book.image_url, url: book.url}, status: status}
  end
end
