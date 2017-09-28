class TransactionsController < ApplicationController
  before_action :authenticate
  before_action :authorize_transaction, only: [:show, :edit]

  def index
    # show transactions of this user
    @transactions = @current_user.transactions.order(created_at: :desc)
    @remaining_balance = @current_user.remaining_balance
    @expense_this_month = @current_user.transactions.where(date: Date.today.beginning_of_month..Date.today.end_of_month, is_expense: true).sum(:amount) 
    @income_this_month = @current_user.transactions.where(date: Date.today.beginning_of_month..Date.today.end_of_month, is_expense: false).sum(:amount) 
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
    @transaction.user = @current_user

    if @transaction.save
      # update total remaining amount
      update_remaining_balance
      flash[:success] = "Transaction has successfully been created"
      redirect_to transaction_path(@transaction)
    else
      flash[:danger] = "Please check that all fields have been filled in correctly"
      redirect_to new_transaction_path
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    payment_methods = @current_user.payment_methods
    @payment_methods_select_options = 
    payment_methods.map do |pm| 
      pm.payment_type == 'Cash' ? ["Cash", pm.id] : ["#{pm.bank} - #{pm.payment_type} (x#{pm.last_four_digits})", pm.id]
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    if @transaction.update(transaction_params)
      # update total remaining amount
      update_remaining_balance
      flash[:success] = "Transaction has successfully been updated"
      redirect_to transaction_path(@transaction)
    else
      flash[:danger] = "Please check that all fields have been filled in correctly"
      redirect_to edit_transaction_path(@transaction)
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    if @transaction.destroy
      # update total remaining amount
      update_remaining_balance_for_destroy
      flash[:warning] = "Successfully deleted transaction"
      redirect_to transactions_path
    else
      flash[:danger] = "Something went wrong. Please try again."
      redirect_to transactions_path
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :name, :location, :description, :date, :category, :is_expense, :payment_method_id)
  end

  def authorize_transaction
    @transaction = Transaction.find(params[:id])
    unless current_user == @transaction.user
      flash[:danger] = "You are not authorized to view that page"
      redirect_to dashboard_path
    end
  end

  def update_remaining_balance
    new_balance = @transaction.is_expense ? current_user.remaining_balance - @transaction.amount : current_user.remaining_balance + @transaction.amount
    # raise new_balance.inspect
    @current_user.update_columns(remaining_balance: new_balance)
    # raise @current_user.remaining_balance.inspect
  end

  def update_remaining_balance_for_destroy
    new_balance = @transaction.is_expense ? current_user.remaining_balance + @transaction.amount : current_user.remaining_balance - @transaction.amount
    # raise new_balance.inspect
    @current_user.update_columns(remaining_balance: new_balance)
  end
end
