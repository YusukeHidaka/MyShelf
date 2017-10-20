class LikesController < ApplicationController
  before_action :set_review
  def create
    @like = Like.create(user_id: current_user.id, review_id: params[:review_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, review_id: params[:review_id])
    like.destroy
  end

  private
  def like_params
    params.permit(
      :user_id,
      :review_id
    )
  end

  def set_review
    @review = Review.find(params[:review_id])
  end
end
