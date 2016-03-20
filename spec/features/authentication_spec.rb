require 'rails_helper'

describe "Authentication" do
  context "user", mock_auth: true do
    before do
      login_as_user
    end

    it "signs in" do
      expect(page).to have_content "Вы вошли с помощью Вконтакте"
      expect(page).to have_content "Выйти"
    end

    it "signs out" do
      click_link "Выйти"
      expect(page).to have_content "Выход из системы выполнен."
      expect(page).to have_content "Войти с помощью Вконтакте"
    end
  end

  context "employee" do
    let(:employee) { create :employee }

    before do
      login_as_employee(employee)
    end

    it "signs in" do
      expect(page).to have_content employee.email
      expect(page).to have_content "Выйти"
    end

    it "signs out" do
      click_link "Выйти"
      expect(current_path).to eq root_path
      expect(page).to have_content "Выход из системы выполнен."
    end
  end
end
