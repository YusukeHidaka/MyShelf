module BookReviewsHelper
  def set_condition
    ColoredBook.all.where(user_id: current_user.id)
  end

  def already_liked(review)
    like = Like.find_by(book_review_id: review["id"], user_id: current_user.id)
    like.present?
  end

  def get_like_id(review)
    like = Like.find_by(book_review_id: review["id"], user_id: current_user.id)
    like.id
  end

  def check_book_reviewed(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    if original_book.present?
      colored_book = ColoredBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
      if colored_book.present?
        book_review = BookReview.find_by(colored_book_id: colored_book.id)
        if book_review.present?
          return book_review
        else
          return false
        end
      else
        return false
      end
    else
      return false
    end
  end

end
