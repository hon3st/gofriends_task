class RenameColumnVkUrlInUsersToProfileUrl < ActiveRecord::Migration
  def change
    rename_column :users, :vk_url, :profile_url
  end
end
