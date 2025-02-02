class User < ApplicationRecord
  has_secure_password

  has_many :credit_cards, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :email_address, presence: true, uniqueness: true
end
