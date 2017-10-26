module OriginalBooksHelper
  def set_book(book, status, action)
    {original_book:{author: book.author, title: book.title, publisher: book.publisher, publication_date: book.publication_date, isbn: book.isbn, image_url: book.image_url, url: book.url}, status: status, action: action}
  end

  def check_shelved(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    if original_book.present?
      shelved_book = ShelvedBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
      if shelved_book.present?
        return shelved_book.status
      else
        return false
      end
    else
      return false
    end
  end

  def get_shelved_book_id(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    unless original_book.present?
      return false
    end
    shelved_book = ShelvedBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
    unless shelved_book.present?
      return false
    end
    shelved_book.attributes["id"]
  end

  def check_reviewed(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    unless original_book.present?
      return false
    end
    shelved_book = ShelvedBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
    unless shelved_book.present?
      return false
    end
    shelved_book_id = shelved_book.attributes["id"]
    Review.find_by(shelved_book_id: shelved_book_id).present?
  end

  def get_review_id(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    shelved_book = ShelvedBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
    unless shelved_book.present?
      return false
    end
    shelved_book_id = shelved_book.attributes["id"]
    review = Review.find_by(shelved_book_id: shelved_book_id)
    review.attributes["id"]
  end
end
