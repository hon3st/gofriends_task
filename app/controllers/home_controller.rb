class HomeController < ApplicationController
  before_action :redirect_employee, only: [:index]

  def index
  end
end
