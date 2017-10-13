class AmazonBook
  attr_accessor :title, :author, :publisher, :publication_date, :isbn, :image_url, :url

  def initialize(title, author, publisher, publication_date, isbn, image_url, url)
    @title = title
    @author = author
    @publisher = publisher
    @publication_date = publication_date
    @isbn =isbn
    @image_url = image_url
    @url = url
  end
end
