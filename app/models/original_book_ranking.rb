class OriginalBookRanking < ApplicationRecord
  belongs_to :original_book, dependent: :destroy

  def update_amount(t, t2)
    shelved_amount = t.read_amount + t.wish_amount + t.tsundoku_amount
    t2.update_attribute(:shelved_amount, shelved_amount)
  end
end
