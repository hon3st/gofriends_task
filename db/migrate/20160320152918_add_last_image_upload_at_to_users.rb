class AddLastImageUploadAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_image_upload_at, :datetime
  end
end
