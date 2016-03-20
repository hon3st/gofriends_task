class User < ActiveRecord::Base
  devise :rememberable, :trackable, :omniauthable,
         omniauth_providers: [:vkontakte]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.image = auth.info.image
      user.profile_url = auth.info.urls[auth.provider.capitalize]
    end
  end
end
