class PaymentMethod < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :bank, presence: true
  validates :last_four_digits, length: { is: 4 }
  validates_numericality_of :last_four_digits
end
