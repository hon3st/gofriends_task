shared_examples "not uploadable" do
  let(:user) { create :user, last_image_upload_at: Time.zone.now }
  let(:auth) { create :vkontakte_auth }
  let(:image_uploader) { Vk::ImageUploader.new(user, auth) }

  it "does not upload an image" do
    expect{image_uploader.call}.not_to change{user.last_image_upload_at}
  end
end
