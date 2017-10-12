class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new
  end

  def create
    Review.create(content: review_params[:content], user_id: current_user.id)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy if review.user_id == current_user.id
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params) if review.user_id == current_user.id
  end

  def show
    @review = Review.find(params[:id])
    # @comments = @review.comments.includes(:user)
  end


  private
  def review_params
    params.permit(:content)
  end
end
