class LikesController < ApplicationController
  def create
    Like.create(like_params)
  end

  def destroy
    target_like = Like.find(params[:id])
    target_like.destroy
  end

  private
  def like_params
    params.permit(
      :user_id,
      :review_id
    )
  end

end
