class ColoredBooksController < ApplicationController
  def index
    @colored_books = ColoredBook.all
  end

  def edit
    @colored_book = ColoredBook.find(params[:id])
  end

  def destroy
    colored_book = ColoredBook.find(params[:id])
    colored_book.destroy
    redirect_to user_path(current_user.id), flash: {success: '削除が完了しました。'}
  end

  private

  def use_before_action?
    true
  end
end
