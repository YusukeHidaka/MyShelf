class Review < ApplicationRecord
  belongs_to :shelved_book
  has_many :likes
  has_many :comments

  # scope :with_shelved_book, -> { joins(:shelved_book) }
  scope :with_user, -> { joins({:shelved_book => :user}) }
  # scope :with_original_book, -> { joins({:shelved_book => :original_book}) }
  scope :search_with_user_id, ->(user_id) { where(:users => {:id => user_id}) }
end
