class LikesController < ApplicationController
  before_action :set_review
  def create
    binding.pry
    @like = Like.create(user_id: current_user.id, book_review_id: params[:book_review_id], comment_id: params[:comment_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, book_review_id: params[:book_review_id], comment_id: params[:comment_id])
    like.destroy
  end

  private
  def like_params
    params.permit(
      :user_id,
      :book_review_id,
      :comment_id
    )
  end

  def set_review
    @book_review = BookReview.find(params[:book_review_id])
  end

  def use_before_action?
    true
  end
end
