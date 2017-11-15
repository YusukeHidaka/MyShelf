class WelcomeController < ApplicationController
  def index
    @colored_book_amount = ColoredBook.all.count
    @page_amount = @colored_book_amount * 350
  end

  private

  def use_before_action?
    false
  end
end
