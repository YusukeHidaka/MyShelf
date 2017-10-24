module ReviewsHelper
  def set_condition
    ShelvedBook.all.where(user_id: current_user.id)
  end

  def already_liked(review)
    like = Like.find_by(review_id: review["id"], user_id: current_user.id)
    like.present?
  end

  def get_like_id(review)
    like = Like.find_by(review_id: review["id"], user_id: current_user.id)
    like.id
  end

  def check_reviewed(isbn)
    original_book = OriginalBook.find_by(isbn: isbn)
    if original_book.present?
      shelved_book = ShelvedBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
      if shelved_book.present?
        review = Review.find_by(shelved_book_id: shelved_book.id)
        if review.present?
          return review
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
