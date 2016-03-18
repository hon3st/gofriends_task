class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user
      flash[:notice] = t(".notice")
    else
      flash[:alert] = t(".alert")
    end

    redirect_to root_path
  end
end
