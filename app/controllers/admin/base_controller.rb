class Admin::BaseController < ApplicationController
  layout "admin"

  before_action :redirect_user
  before_action :authenticate_employee!
end
