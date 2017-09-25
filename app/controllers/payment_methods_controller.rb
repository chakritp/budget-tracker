class PaymentMethodsController < ApplicationController
  def index
    # List only payment method of this user
    @payment_methods = PaymentMethod.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
