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
end
