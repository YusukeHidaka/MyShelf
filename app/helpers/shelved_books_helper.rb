module ShelvedBooksHelper
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

  def check_wish_status(status)
    if status == "wish"
      return "読みたい本から削除"
    else
      return "読みたい本に追加"
    end
  end

  def check_read_status(status)
    if status == "read"
      return "読んだ本から削除"
    else
      return "読んだ本に追加"
    end
  end

  def check_tsundoku_status(status)
    if status == "tsundoku"
      return "積読本から削除"
    else
      return "積読本に追加"
    end
  end
end
