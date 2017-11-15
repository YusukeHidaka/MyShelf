module OriginalBooksHelper
  def set_book(book, status, kind)
    {original_book:{author: book.author, title: book.title, publisher: book.publisher, publication_date: book.publication_date, isbn: book.isbn, image_url: book.image_url, url: book.url}, status: status, kind: kind}
  end

  def check_colored(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    if original_book.present?
      colored_book = ColoredBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
      if colored_book.present?
        return colored_book.status
      else
        return false
      end
    else
      return false
    end
  end

  def get_colored_book_id(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    unless original_book.present?
      return false
    end
    colored_book = ColoredBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
    unless colored_book.present?
      return false
    end
    colored_book.attributes["id"]
  end

  def check_book_reviewed(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    unless original_book.present?
      return false
    end
    colored_book = ColoredBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
    unless colored_book.present?
      return false
    end
    colored_book_id = colored_book.attributes["id"]
    BookReview.find_by(colored_book_id: colored_book_id).present?
  end

  def get_book_review_id(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    colored_book = ColoredBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
    unless colored_book.present?
      return false
    end
    colored_book_id = colored_book.attributes["id"]
    book_review = BookReview.find_by(colored_book_id: colored_book_id)
    book_review.attributes["id"]
  end
end
