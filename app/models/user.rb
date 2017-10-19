class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :shelved_books, dependent: :destroy

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
end
