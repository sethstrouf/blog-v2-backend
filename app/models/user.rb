class User < ApplicationRecord
  has_many :api_keys, as: :bearer, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
