class OriginalBooksController < ApplicationController
  def index
    @user = current_user
    @original_books = OriginalBook.all
  end

  def new
  end

  def create
    original_book = create_original_book
    create_shelved_book(original_book)
  end

  def create_original_book
    # この辺はモデルに切り出したい。コントローラーはルーティングだけ。
    if original_book = OriginalBook.find_by(isbn: params[:original_book][:isbn])
      if original_book.image_url.nil?
        original_book.update_attributes(image_url: params[:original_book][:image_url])
      end
      return original_book
    else
      original_book = OriginalBook.new(original_book_params)

      if original_book.save
        return original_book
      else
        flash.now[:alert] = "Some errors occured"
        render search_original_books_path
      end
    end
  end

  def create_shelved_book(original_book)
    # ranking がない場合作成
    original_book_ranking = OriginalBookRanking.find_by(original_book_id: original_book.id)
    unless original_book_ranking.present?
      OriginalBookRanking.create(original_book_id: original_book.id)
    end

    if shelved_book = ShelvedBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
      # statusをupdate
      shelved_book.update_attributes(status: params[:status])
      # read関連のamountを更新
      shelved_book.update_status_amount(original_book)

      # ranking用のデータを更新
      original_book_ranking.update_amount(original_book, original_book_ranking)

      if params[:kind] == "review"
        redirect_to new_review_path(id: shelved_book.id)
      else
        message = '「' + original_book.title + '」のステータスを「' + params[:status] + '」に変更しました'
        redirect_back fallback_location: authenticated_root_path, flash: { success: message}
      end
    else
      shelved_book = ShelvedBook.new(original_book_id: original_book.id, status: params[:status], user_id: current_user.id)
      if shelved_book.save
        # read関連のamountを更新
        shelved_book.update_status_amount(original_book)
        # ranking用のデータを更新
        original_book_ranking.update_amount(original_book, original_book_ranking)

        if params[:kind] == "review"
          redirect_to new_review_path(id: shelved_book.id)
        else
          message = '本棚に「' + original_book.title + '」を追加しました'
          redirect_back fallback_location: authenticated_root_path, flash: { success: message }
        end
      else
        flash.now[:alert] = "Some errors occured"
        render search_original_books_path
      end
    end
  end

  def search
    if params[:user_search]
      redirect_to search_users_path(keyword: params[:keyword])
    else
      @amazon_books = Book.search_amazon(params)
      @user = current_user
    end
  end

  private

  def original_book_params
    params.require(:original_book).permit(:title, :author, :image_url, :publisher, :isbn, :publication_date, :read_amount, :tsundoku_amount, :wish_amount, :url)
  end

  def use_before_action?
    true
  end
end
