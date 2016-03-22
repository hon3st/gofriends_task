require 'rails_helper'

describe "Messages" do
  let(:employee) { create :employee }
  let(:message) { create :message }

  before do
    login_as_employee(employee)
  end

  context "when there is no messages" do
    it "tells that there is no messages" do
      visit admin_messages_path
      expect(page).to have_content "Нет сообщений"
    end
  end

  context "when there is some messages" do
    let!(:message) { create :message }

    it "shows those messages" do
      visit admin_messages_path
      expect(page).to have_content message.description
      expect(page).not_to have_content "Нет сообщений"
    end
  end

  it "creates new message" do
    expect {
      visit new_admin_message_path
      attach_file :message_image, Rails.root + 'spec/support/images/image.jpg'
      fill_in :message_description, with: "Some description"
      click_button "Создать сообщение"
    }.to change{Message.count}.from(0).to(1)

    expect(page).to have_content "Сообщение создано"
  end

  it "edits message" do
    new_description = "Another description"
    visit edit_admin_message_path(message)
    fill_in :message_description, with: new_description
    click_button "Обновить сообщение"
    expect(message.reload.description).to eq new_description
    expect(page).to have_content "Сообщение обновлено"
  end

  it "removes message" do
    create :message
    visit admin_messages_path
    expect{click_link "Удалить"}.to change{Message.count}.from(1).to(0)
    expect(page).to have_content "Сообщение удалено"
  end
end
