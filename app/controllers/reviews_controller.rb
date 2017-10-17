class ReviewsController < ApplicationController
  def index
    @reviews = Review.page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    @review = Review.new
  end

  def create
    Review.create(review_params)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy if review.shelved_book.user_id == current_user.id
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params) if review.shelved_book.user_id == current_user.id
  end

  def show
    @review = Review.find(params[:id])
    # @comments = @review.comments.includes(:user)
  end


  private
  def review_params
    params.require(:review).permit(:content, :shelved_book_id)
  end
end
