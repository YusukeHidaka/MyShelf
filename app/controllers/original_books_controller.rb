class OriginalBooksController < ApplicationController
  def index
    @original_books = OriginalBook.all
  end

  def search
    if params[:keyword].present?
      #　デバックログ出力するために記述
      Amazon::Ecs.debug = true

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
    params.require(:original_book).permit(:title, :author, :image_url, :publisher, :isbn, :publish_date, :read_amount, :tsundoku_amount)
  end
end
