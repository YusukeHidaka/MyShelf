require 'mechanize'

class Scraping < ApplicationRecord
  def self.book_urls
    agent = Mechanize.new
    links = []

    puts "-----------------"
    puts "-----------------"
    puts "scraping starting"
    puts "-----------------"
    puts "-----------------"

    puts "-----------------"
    puts "-----------------"
    puts ".........Fetching URLs"
    puts "-----------------"
    puts "-----------------"

    # while true
      current_page = agent.get("https://bookmeter.com/rankings")
      elements = current_page.search('.detail__title a')
      puts "elements"
      puts elements
      elements.each do |ele|
        puts "ele"
        puts ele
        links << ele.get_attribute('href')
      end
    # end

    puts "-------------------"
    puts "links"
    puts "-------------------"

    links.each do |link|
      get_product('https://bookmeter.com' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.inner__title').inner_text if page.at('.inner__title')
    image_url = page.at('.image__cover img')[:src] if page.at('.image__cover img')
    author = page.at('.header__authors a').inner_text if page.at('.header__authors a')
    description = page.at('.book-summary__default p').inner_text if page.at('.book-summary__default p')

    original_book = OriginalBook.where(title: title).first_or_initialize
    original_book.image_url = image_url
    original_book.author = author
    original_book.description = description
    original_book.save
  end
end
