class Item
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  #property :client, Integer  # 依頼主
  property :amount, Integer  # 必要な個数
  property :gained, Integer, :default => 0 # 集まった個数
  property :body, Text  # 説明

  belongs_to :client
end

