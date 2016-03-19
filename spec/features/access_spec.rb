require 'rails_helper'

describe "Access" do
  context "when user not signed in" do
    it "restricts access to admin panel" do
      visit admin_root_path
      expect(current_path).not_to eq admin_root_path
    end
  end

  context "when user signed in", mock_auth: true do
    before do
      login_as_user
    end

    it "restricts access to admin panel" do
      visit admin_root_path
      expect(current_path).not_to eq admin_root_path
    end

    it "restricts access to login as employee page" do
      visit new_employee_session_path
      expect(current_path).not_to eq new_employee_session_path
    end
  end

  context "when employee signed in" do
    let(:employee) { create :employee }

    before do
      login_as_employee(employee)
    end

    it "grants access to admin panel" do
      visit admin_root_path
      expect(current_path).to eq admin_root_path
    end

    it "does not allow to sign in as user" do
      visit user_omniauth_authorize_path(:vkontakte)
      expect(current_path).to eq admin_root_path
    end

    it "redirects from root page" do
      visit root_path
      expect(current_path).to eq admin_root_path
    end
  end
end
