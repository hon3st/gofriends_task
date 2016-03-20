class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :redirect_employee

  def vkontakte
    @authenticator = VkAuthenticator.new(request.env["omniauth.auth"])

    if @authenticator.call
      sign_in @authenticator.user
      flash[:notice] = t(".notice")
    else
      flash[:alert] = t(".alert")
    end

    redirect_to root_path
  end
end
