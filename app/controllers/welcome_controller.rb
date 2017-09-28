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

    gon.expense_data_set = prepare_data('expense')
    gon.income_data_set = prepare_data('income')

    render layout: 'application'
  end

  private

  def prepare_data(type)
    flag = (type == 'expense')
    records = @current_user.transactions.where(date: Date.today.beginning_of_month..Date.today.end_of_month, is_expense: flag)
    data = Hash.new(0.0)
    records.map do |e|
      category = e.category.nil? ? "None" : e.category
      data[category.to_sym] += e.amount
    end
    data.to_a
  end
end
