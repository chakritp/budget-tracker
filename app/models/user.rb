class User < ApplicationRecord
  has_secure_password

  has_many :payment_methods
  has_many :transactions, through: :payment_methods
end
