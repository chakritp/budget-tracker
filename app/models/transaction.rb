class Transaction < ApplicationRecord
  belongs_to :payment_method
  belongs_to :user

  validates :amount, :name, presence: true
  validates_numericality_of :amount
end
