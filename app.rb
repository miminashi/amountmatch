require 'data_mapper'
require 'dm-pager'
require 'sinatra'
require 'haml'

require 'lib/item'
require 'lib/client'

if ENV['RACK_ENV'] == 'production'
  DataMapper.setup(:default, ENV['DATABASE_URL'])
elsif ENV['RACK_ENV'] = 'development'
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, {:adapter => 'sqlite3', :database => 'db/development.db'})
end

configure do
  set :haml, :format => :html5
  set :sessions, true
  #session[:client] = Client.first.id
  #p Client.first.id
  #p session[:client]
end

helpers do
  def validate(params)

  end

  def uniq_clients(items)
    items.map{|item| item.client}.uniq
  end
end

get '/' do
  if !session[:client]
    session[:client] = Client.first.id
    p Client.first.id
    p session[:client]
  end
  @items = Item.all
  p @items
  #p Client.all(:id => uniq_clients(@items))

  haml :index
end

get '/item/:id/entry' do
  @item = Item.first(:id => params[:id])
  @togo = @item.amount - @item.gained
  haml :item_entry
end

post '/item/:id/entry' do
  item = Item.first(:id => params[:id])
  item.gained = item.gained + params[:amount].to_i
  item.save
  redirect "/item/#{params[:id]}/show"
end

get '/item/:id/show' do
  @item = Item.first(:id => params[:id])
  haml :item_show
end

get '/item/new' do
  haml :item_new
end

post '/item/new' do
  p params
  @client = Client.first(:id => session[:client])
  item = Item.create(
    :title => params[:title],
    #:client => session[:client],
    :amount => params[:amount],
    :body => params[:body]
  )
  @client.items << item
  @client.save
  redirect '/'
end

get '/item/:id/edit' do
  @item = Item.first(:id => params[:id])
  haml :item_edit
end

post '/item/:id/edit' do
  p params
  item = Item.first(:id => params[:id])
  item.title = params[:title]
  item.amount = params[:amount]
  item.body = params[:body]
  item.save
  redirect '/'
end

get '/item/:id' do
  haml :item
end


get '/client/:id' do
  haml :client
end

