class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end
end
