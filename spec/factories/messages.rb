FactoryGirl.define do
  factory :message do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'image.jpg')) }
    description "Some description"
  end
end
