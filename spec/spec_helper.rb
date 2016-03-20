require 'omniauth'

RSpec.configure do |config|
  Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before :all, mock_auth: true do
    OmniAuth.config.test_mode = true
  end
end

OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new({
  provider: "vkontakte",
  uid: "123456",
  info: {
    name: "My name",
    image: "http://vk.com/images/camera_100.png",
    urls: { "Vkontakte" => "http://vk.com/id123456" }
  }
})
