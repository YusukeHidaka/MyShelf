class OriginalBooksController < ApplicationController
  def index
    @original_books = OriginalBook.all
  end

  def new
  end

  def create
    original_book = create_original_book
    create_shelved_book(original_book)
  end

  def create_original_book
    if original_book = OriginalBook.find_by(isbn: params[:original_book][:isbn])
      if original_book.image_url.nil?
        original_book.update_attributes(image_url: params[:original_book][:image_url])
      end
      return original_book
      # redirect_to controller: 'shelved_books', action: 'create', original_book: original_book
    else
      original_book = OriginalBook.new(original_book_params)
      if original_book.save
        return original_book
      else
        flash.now[:alert] = "Some errors occured"
        render :action => :search
      end
    end
  end

  def create_shelved_book(original_book)
    if shelved_book = ShelvedBook.find_by(original_book_id: original_book.id, user_id: current_user.id)
      # statusをupdate
      shelved_book.update_attributes(status: params[:status])

      # read関連のamountを更新
      shelved_book.update_status_amount(original_book)

      redirect_to controller: 'shelved_books', action: 'shelved_books', user_id: current_user.id
    else
      shelved_book = ShelvedBook.new(original_book_id: original_book.id, status: params[:status], user_id: current_user.id)
      if shelved_book.save
        # read関連のamountを更新
        shelved_book.update_status_amount(original_book)
        redirect_to controller: 'shelved_books', action: 'shelved_books', user_id: current_user.id
      else
        flash.now[:alert] = "Some errors occured"
        render :action => :search
      end
    end
  end

  def search
    if params[:keyword].present?
      # デバックログ出力するために記述
      Amazon::Ecs.debug = true

      # 理不尽に制限に引っかかるので、10回までリトライする設定
      # https://blog.hello-world.jp.net/ruby/2204/
      retry_count = 0
      begin
        # Amazon::Ecs::Responceオブジェクトの取得
        books = Amazon::Ecs.item_search(
          params[:keyword],
          search_index:  'Books',
          dataType: 'script',
          response_group: 'ItemAttributes, Images',
          sort: 'salesrank',
          country:  'jp',
          power: "Not kindle"
        )
      rescue => e
        retry_count += 1
        logger.error e.message
        if retry_count < 10
          sleep(3)
          retry
        end
      end

      # 本のタイトル,画像URL, 詳細ページURLの取得
      @amazon_books = []
      books.items.each do |item|
        book = AmazonBook.new(
          item.get('ItemAttributes/Title'),
          item.get('ItemAttributes/Author'),
          item.get('ItemAttributes/Publisher'),
          item.get('ItemAttributes/PublicationDate'),
          item.get('ItemAttributes/ISBN'),
          item.get('LargeImage/URL'),
          item.get('DetailPageURL'),
        )
        @amazon_books << book
      end
    end
  end

  private

  def original_book_params
    params.require(:original_book).permit(:title, :author, :image_url, :publisher, :isbn, :publish_date, :read_amount, :tsundoku_amount, :wish_amount)
  end

  def shelved_book_params
    params.require(:shelved_book).permit(:original_book_id, :status, :user_id)
  end
end
