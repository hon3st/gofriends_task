class HomeController < ApplicationController
  def index
    redirect_to admin_root_path if employee_signed_in?
  end
end
