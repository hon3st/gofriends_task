require 'rails_helper'

describe Vk::ImageUploader do
  let(:user) { create :user }
  let(:auth) { create :vkontakte_auth }
  let(:image_uploader) { Vk::ImageUploader.new(user, auth) }

  describe "#call" do
    context "when image was already posted within last 24 hours" do
      before do
        create :message
      end

      it_behaves_like "not uploadable"
    end

    context "when there is no images" do
      it_behaves_like "not uploadable"
    end

    it "updates user's last image upload time" do
      create :message
      stub_vk_image_upload
      expect{image_uploader.call}.to change{user.last_image_upload_at}
    end
  end
end
