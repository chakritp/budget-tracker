class WelcomeController < ApplicationController
  before_action :authenticate, only: [:dashboard]
  before_action :redirect_to_dashboard, only: [:index]

  def index
    render layout: 'welcome'
  end

  def dashboard
    @remaining_balance = @current_user.remaining_balance
    @expense_this_month = @current_user.transactions.where(date: Date.today.beginning_of_month..Date.today.end_of_month, is_expense: true).sum(:amount) 
    @income_this_month = @current_user.transactions.where(date: Date.today.beginning_of_month..Date.today.end_of_month, is_expense: false).sum(:amount)

    gon.expense_data_set = [1, 4, 5]
    gon.income_data_set = [7, 12, 9]

    render layout: 'application'
  end
end
