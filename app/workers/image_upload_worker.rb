class ImageUploadWorker
  include Sidekiq::Worker

  def perform(user_id, auth)
    user = User.find(user_id)
    Vk::ImageUploader.new(user, auth).call
  end
end
