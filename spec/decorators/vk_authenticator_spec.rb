require 'rails_helper'

describe VkAuthenticator do
  let(:auth) { create :vkontakte_auth }
  let(:vk_authenticator) { VkAuthenticator.new(auth) }

  describe "#call" do
    it "returns found user" do
      expect(vk_authenticator.call).to be_instance_of User
    end

    it "uploads image in background" do
      expect{vk_authenticator.call}.to change{ImageUploadWorker.jobs}
    end
  end
end
