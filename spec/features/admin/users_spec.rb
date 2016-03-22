require 'rails_helper'

describe "Users" do
  let(:employee) { create :employee }

  it "shows users authenticated via vk" do
    login_as_user
    logout
    login_as_employee(employee)
    visit admin_users_path
    expect(page).to have_content "My name"
  end
end
