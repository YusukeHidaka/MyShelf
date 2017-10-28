class ShelvedBooksController < ApplicationController
  def index
    @shelved_books = ShelvedBook.all
  end

  def edit
    @shelved_book = ShelvedBook.find(params[:id])
  end

  def destroy
    shelved_book = ShelvedBook.find(params[:id])
    shelved_book.destroy
    redirect_to user_path(current_user.id), flash: {success: '削除が完了しました。'}
  end

  private

  def use_before_action?
    true
  end
end
