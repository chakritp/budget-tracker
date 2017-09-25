class Transaction < ApplicationRecord
  belongs_to :payment_method
end
