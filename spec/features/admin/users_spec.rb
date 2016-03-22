require 'rails_helper'

describe "Users" do
  let(:employee) { create :employee }

  before do
    create :user
  end

  it "shows users authenticated via vk" do
    login_as_employee(employee)
    visit admin_users_path
    expect(page).to have_content "My Name"
  end
end
