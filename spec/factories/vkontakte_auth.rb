FactoryGirl.define do
  factory :vkontakte_auth, class: OmniAuth::AuthHash do
    skip_create

    transient do
      sequence(:id) { |n| "123#{n}" }
      name "My Name"
      image "http://vk.com/images/camera_100.png"
      url { "http://vk.com/id#{id}" }
      token { SecureRandom.urlsafe_base64(100).delete("-_").first(100) }
      expires_at { SecureRandom.random_number(1.month).seconds.from_now }
    end

    provider "vkontakte"
    uid { id }

    info do
      {
        name: name,
        image: image,
        urls: {"Vkontakte" => url}
      }
    end

    credentials do
      {
        token: token,
        expires_at: expires_at.to_i,
        expires: true
      }
    end
  end
end
