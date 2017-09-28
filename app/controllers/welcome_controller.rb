class WelcomeController < ApplicationController
  before_action :authenticate, only: [:dashboard]
  before_action :redirect_to_dashboard, only: [:index]

  def index
    render layout: 'welcome'
  end

  def dashboard
    render layout: 'application'
  end
end
