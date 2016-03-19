class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def redirect_user
    redirect_to root_path if user_signed_in?
  end

  def redirect_employee
    redirect_to admin_root_path if employee_signed_in?
  end
end
