class Client
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :profile_image_url, String

  has n, :items
end

