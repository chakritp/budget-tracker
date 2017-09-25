class WelcomeController < ApplicationController
  def index
    render layout: 'welcome'
  end

  def dashboard
    render layout: 'application'
  end
end
