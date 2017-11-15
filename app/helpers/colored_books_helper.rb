module ColoredBooksHelper
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

  def check_quit_status(status)
    if status == "quit"
      return "辞めた本から削除"
    else
      return "辞めた本に追加"
    end
  end
end
