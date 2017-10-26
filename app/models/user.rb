class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :shelved_books, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first

    unless user
      user = User.create(
        name:     auth.info.name,
        provider: auth.provider,
        uid:      auth.uid,
        email:    auth.info.email,
        token:    auth.credentials.token,
        password: Devise.friendly_token[0, 20],
        image:    auth.info.image)
    end
    user
  end

  def self.count_books(t_user)
    ShelvedBook.where(user_id: t_user.id).count
  end

  def self.count_read_books(t_user)
    ShelvedBook.where(user_id: t_user.id, status: "read").count
  end

  def self.count_tsundoku_books(t_user)
    ShelvedBook.where(user_id: t_user.id, status: "tsundoku").count
  end

  def self.count_wish_books(t_user)
    ShelvedBook.where(user_id: t_user.id, status: "wish").count
  end

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
end
