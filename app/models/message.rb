class Message < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :image, :description, presence: true

  scope :random, -> { order("RANDOM()") }
end
