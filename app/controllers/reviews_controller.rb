class ReviewsController < ApplicationController
  def index
    @reviews = Review.page(params[:page]).per(5).order("created_at DESC")
  end

  def new
    # TODO:params(指定のshelved_book.id)がなかった場合本棚に飛ばす処理
    if params[:id].nil?
      # redirect_to shelf_users_path(current_user.id), flash: {notice: 'レビューを書く本を選択してください'}
    end
    @shelved_book = ShelvedBook.find(params[:id])

    # レビューがすでにあるかどうかを、shelved_book.idで確認する。
    if @shelved_book.review.present?
      redirect_to edit_review_path(@shelved_book.review.id)
      @review = @shelved_book.review
    else
      @review = Review.new
    end
  end

  def create
    # 存在したら勝手にアップデートにしてくれる
    Review.create(review_params)
    redirect_to reviews_path, flash: {notice: 'レビューを投稿しました'}
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy if review.shelved_book.user_id == current_user.id
    redirect_to reviews_path, flash: {notice: '削除が完了しました。'}
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params) if review.shelved_book.user_id == current_user.id
    redirect_to reviews_path, flash: {notice: 'レビューを更新しました'}
  end

  private
  def review_params
    params.require(:review).permit(:content, :shelved_book_id)
  end
end
