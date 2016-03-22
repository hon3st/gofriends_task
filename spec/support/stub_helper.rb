def stub_vk_request(path, body)
  stub_request(:post, /#{path}/).
    with(headers: {"Accept" => "*/*"}).
    to_return(status: 200, body: body.to_json, headers: {'Content-Type' => 'application/json'})
end

def stub_vk_image_upload
  stub_vk_request("getAlbums", response: [{title: "GoFriends"}])
  stub_vk_request("getUploadServer", response: {upload_url: "http://vk.com/server"})
  stub_vk_request("server", response: "done")
  stub_vk_request("photos.save", response: "done")
end
