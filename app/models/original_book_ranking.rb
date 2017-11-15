class OriginalBookRanking < ApplicationRecord
  belongs_to :original_book, dependent: :destroy

  def update_amount(t, t2)
    colored_amount = t.read_amount + t.wish_amount + t.tsundoku_amount + t.quit_amount
    t2.update_attribute(:colored_amount, colored_amount)
  end
end
