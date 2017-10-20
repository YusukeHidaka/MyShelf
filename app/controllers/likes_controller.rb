class LikesController < ApplicationController
  def create
    @like = Like.create(user_id: current_user.id, review_id: params[:review_id])
    @likes = Like.where(review_id: params[:review_id])
    @reviews = Review.all
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, review_id: params[:review_id])
    like.destroy
    @likes = Like.where(review_id: params[:review_id])
    @reviews = Review.all
  end

  private
  def like_params
    params.permit(
      :user_id,
      :review_id
    )
  end

end
