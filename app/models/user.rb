class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :payment_methods
  has_many :transactions, through: :payment_methods

end
