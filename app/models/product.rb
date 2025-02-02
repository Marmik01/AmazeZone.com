class Product < ApplicationRecord
  has_many :transactions, dependent: :destroy
end
