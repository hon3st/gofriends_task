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
        expect(User.from_omniauth(vkontakte_auth)).to be_kind_of User
      end

      it "creates user with right info" do
        user = User.from_omniauth(vkontakte_auth)
        expect(user.uid).to eq vkontakte_auth.uid
      end
    end
  end
end
