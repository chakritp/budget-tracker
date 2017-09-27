class TransactionsController < ApplicationController
  def index
    # show transactions of this user
    @transactions = Transaction.order(created_at: :desc)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    payment_methods = current_user.payment_methods
    @payment_methods_select_options = 
      payment_methods.map do |pm| 
        pm.payment_type == 'Cash' ? ["Cash", pm.id] : ["#{pm.bank} - #{pm.payment_type} (x#{pm.last_four_digits})", pm.id]
      end
    
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    if @transaction.save
      flash[:success] = "Transaction has successfully been created"
      redirect_to transaction_path(@transaction)
    else
      flash[:danger] = "Please check that all fields have been filled in correctly"
      redirect_to new_transaction_path
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to transaction_path(@transaction)
    else
    end
  end

  def destroy
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :name, :location, :description, :date, :category, :is_expense, :payment_method_id)
  end
end
