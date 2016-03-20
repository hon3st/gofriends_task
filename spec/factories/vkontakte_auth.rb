FactoryGirl.define do
  factory :vkontakte_auth, class: OmniAuth::AuthHash do
    skip_create

    transient do
      sequence(:id) { |n| "123#{n}" }
      name "My Name"
      image "http://vk.com/images/camera_100.png"
      url { "http://vk.com/id#{id}" }
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
  end
end
