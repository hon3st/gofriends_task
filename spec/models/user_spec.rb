require 'rails_helper'

describe User do
  let(:user) { create :user }
  let(:vkontakte_auth) { create :vkontakte_auth }

  describe ".from_omniauth" do
    context "when user already exists" do
      let!(:user) { create :user }
      let(:vkontakte_auth) do
        create :vkontakte_auth, provider: user.provider, uid: user.uid
      end

      it "does not create new user" do
        expect{
          User.from_omniauth(vkontakte_auth)
        }.not_to change{User.count}
      end

      it "returns that user" do
        expect(User.from_omniauth(vkontakte_auth)).to eq user
      end
    end

    context "when user does not exist" do
      it "creates new user" do
        expect{
          User.from_omniauth(vkontakte_auth)
        }.to change{User.count}.from(0).to(1)
      end

      it "returns user" do
        expect(User.from_omniauth(vkontakte_auth)).to be_instance_of User
      end

      it "creates user with right info" do
        user = User.from_omniauth(vkontakte_auth)
        expect(user.uid).to eq vkontakte_auth.uid
      end
    end
  end

  describe "#image_upload_allowed?" do
    context "when last_image_upload_at is not set" do
      it "returns true" do
        user.last_image_upload_at = nil
        expect(user.image_upload_allowed?).to be true
      end
    end

    context "when last_image_upload_at is within last 24 hours" do
      it "returns false" do
        user.last_image_upload_at = Time.zone.now
        expect(user.image_upload_allowed?).to be false
      end
    end

    context "when last_image_upload_at is more than 1 day ago" do
      it "returns true" do
        user.last_image_upload_at = Time.zone.now - 2.days
        expect(user.image_upload_allowed?).to be true
      end
    end
  end

  describe "#update_image_upload_time" do
    it "updates user's last upload time" do
      expect{user.update_image_upload_time}.to change{user.last_image_upload_at}
    end
  end
end
