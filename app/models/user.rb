class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :payment_methods, dependent: :destroy
  has_many :transactions, through: :payment_methods, dependent: :destroy

  after_create :initialize_with_cash_payment_method

  has_attached_file :avatar,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  def initialize_with_cash_payment_method
    pm = self.payment_methods.new(payment_type: "Cash")
    pm.save(validate: false)
  end
end
