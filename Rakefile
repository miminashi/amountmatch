require 'rubygems'
require 'data_mapper'

require 'lib/item'
require 'lib/client'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, {:adapter => 'sqlite3', :database => 'db/development.db'})

namespace :db do
  task :migrate do
    DataMapper.auto_migrate!
  end
  task :update do
    DataMapper.auto_upgrade!
  end
  task :load_default do
    Client.create(:name => '女川小学校')
  end
end
