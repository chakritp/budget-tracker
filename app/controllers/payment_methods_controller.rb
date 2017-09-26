class PaymentMethodsController < ApplicationController
  def index
    # List only payment method of this user
    @payment_methods = PaymentMethod.all
  end

  def show
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    @payment_method.user = current_user

    if @payment_method.save
      flash[:success] = "You have successfully added a new card"
      redirect_to payment_methods_path
    else
      flash[:danger] = "Please ensure the fields are filled in correctly"
      redirect_to new_payment_method_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @payment_method = PaymentMethod.find(params[:id])
    if @payment_method.destroy
      flash[:success] = "Card #{@payment_method.bank} #{@payment_method.last_four_digits} has been successfully deleted"
      redirect_to payment_methods_path
    else
      flash[:danger] = "Something went wrong. Please try again."
      redirect_to payment_methods_path
    end
  end

  private
  
  def payment_method_params
    params.require(:payment_method).permit(:payment_type, :bank, :last_four_digits)
  end
end
