class WelcomeController < ApplicationController
  def index
    @shelved_book_amount = ShelvedBook.all.count
    @page_amount = @shelved_book_amount * 350
  end

  private

  def use_before_action?
    false
  end
end
