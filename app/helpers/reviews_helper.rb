module ReviewsHelper
  def set_condition
    ShelvedBook.all.where(user_id: current_user.id)
  end
end
