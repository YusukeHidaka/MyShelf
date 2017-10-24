class Review < ApplicationRecord
  belongs_to :shelved_book
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end

  scope :with_shelved_book, -> { joins({:shelved_book => :original_book}) }
  scope :with_user, -> { joins({:shelved_book => :user}) }
  # scope :with_original_book, -> { joins({:shelved_book => :original_book}) }
  scope :search_with_original_book_id, ->(original_book_id) { where(:original_books => {:id => original_book_id}) }
  scope :search_with_user_id, ->(user_id) { where(:users => {:id => user_id}) }
end
