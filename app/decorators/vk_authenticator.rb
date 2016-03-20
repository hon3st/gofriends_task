class VkAuthenticator
  attr_reader :user

  def initialize(auth)
    @auth = auth
  end

  def call
    @user = User.from_omniauth(@auth)

    if @user.persisted?
      Vk::ImageUploader.new(@user, @auth).call
      @user
    end
  end
end
