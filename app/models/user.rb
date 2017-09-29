class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :payment_methods
  has_many :transactions, through: :payment_methods

  after_create :initialize_with_cash_payment_method
  
  def initialize_with_cash_payment_method
    pm = self.payment_methods.new(payment_type: "Cash")
    pm.save(validate: false)
  end
end
