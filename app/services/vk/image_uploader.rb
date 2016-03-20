class Vk::ImageUploader
  ALBUM_NAME = "GoFriends"

  def initialize(user, auth)
    @image = Message.random.take.try(:image)
    @user = user
    @auth = auth
    @client = VkontakteApi::Client.new(@auth["credentials"]["token"])
  end

  def call
    return unless @image

    if @user.image_upload_allowed?
      upload(@image)
      @user.update_image_upload_time
    end
  end

  private

  def upload(image)
    album = get_or_create_album(ALBUM_NAME)
    server = @client.photos.get_upload_server(album_id: album.aid)
    photos_info = VkontakteApi.upload(url: server.upload_url, photo: @image.path)

    @client.photos.save(photos_info)
  end

  def get_or_create_album(name)
    if album_exists?(name)
      get_album_by_name(name)
    else
      create_album(name)
    end
  end

  def create_album(name)
    @client.photos.create_album(title: name)
  end

  def get_album_by_name(name)
    albums.select { |album| album.title == name }.first
  end

  def album_exists?(name)
    albums.map(&:title).include?(name)
  end

  def albums
    @albums ||= @client.photos.get_albums(owner_id: @auth["uid"])
  end
end
