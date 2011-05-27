require 'rubygems'
require 'data_mapper'

require 'lib/item'
require 'lib/client'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, {:adapter => 'sqlite3', :database => 'db/development.db'})

=begin
class Item
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :client, Integer  # 依頼主
  property :amount, Integer  # 必要な個数
  property :gained, Integer  # 集まった個数
  property :body, Text  # 説明
end

class Client
  include DataMapper::Resource

  property :id, Serial
  property :name, String
end
=end

DataMapper.auto_migrate!

Client.create(:name => '女川小学校')
p Client.all

