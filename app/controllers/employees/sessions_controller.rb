class Employees::SessionsController < Devise::SessionsController
  before_action :redirect_user
end
