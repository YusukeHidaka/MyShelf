class BookReviewsController < ApplicationController
  def index
    @book_reviews = BookReview.page(params[:page]).per(10).order("updated_at DESC")
    @user = current_user
  end

  def new
    @user = current_user
    # TODO:params(指定のcolored_book.id)がなかった場合本棚に飛ばす処理
    if params[:id].nil?
      # redirect_to user_path(current_user.id), flash: {notice: 'レビューを書く本を選択してください'}
    end
    @colored_book = ColoredBook.find(params[:id])

    # レビューがすでにあるかどうかを、colored_book.idで確認する。
    if @colored_book.book_review.present?
      redirect_to edit_book_review_path(@colored_book.book_review.id)
      @book_review = @colored_book.review
    else
      @book_review = BookReview.new
    end
  end

  def create
    # 存在したら勝手にアップデートにしてくれる
    BookReview.create(book_review_params)
    redirect_to book_reviews_path, flash: {success: 'レビューを投稿しました'}
  end

  def destroy
    book_review = BookReview.find(params[:id])
    book_review.destroy if book_review.colored_book.user_id == current_user.id
    redirect_to book_reviews_path, flash: {success: '削除が完了しました。'}
  end

  def edit
    @book_review = BookReview.find(params[:id])
    @user = current_user
  end

  def update
    book_review = BookReview.find(params[:id])
    book_review.update(book_review_params) if book_review.colored_book.user_id == current_user.id
    redirect_to book_reviews_path, flash: {success: 'レビューを更新しました'}
  end

  private
  def book_review_params
    params.require(:book_review).permit(:content, :colored_book_id)
  end

  def use_before_action?
    true
  end
end
