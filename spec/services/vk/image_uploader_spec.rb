require 'rails_helper'

describe Vk::ImageUploader do
  let(:user) { create :user }
  let(:auth) { create :vkontakte_auth }
  let(:image_uploader) { Vk::ImageUploader.new(user, auth) }

  describe "#call" do
    context "when image was already posted within last 24 hours" do
      let(:user) { create :user, last_image_upload_at: Time.zone.now }

      before do
        create :message
      end

      it "does not post an image" do
        expect{image_uploader.call}.not_to change{user.last_image_upload_at}
      end
    end

    context "when there is no images" do
      it "stops execution" do
        expect{image_uploader.call}.not_to change{user.last_image_upload_at}
      end
    end

    it "updates user's last image upload time" do
      create :message
      stub_vk_image_upload
      expect{image_uploader.call}.to change{user.last_image_upload_at}
    end
  end
end
