class VkAuthenticator
  attr_reader :user

  def initialize(auth)
    @auth = auth
  end

  def call
    @user = User.from_omniauth(@auth)

    if @user.persisted?
      ImageUploadWorker.perform_async(@user.id, @auth)
      @user
    end
  end
end
