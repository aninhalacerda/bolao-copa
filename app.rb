require 'sinatra'
require 'slim'
require 'sinatra/activerecord'
require 'yaml'
require 'sinatra-env'
require 'pry'

require './models/group.rb'
require './models/game.rb'
require './models/user.rb'
require './models/tip.rb'

DB_CONFIG = YAML.load(ERB.new(File.read(File.join("config","database.yml"))).result)[Sinatra.env]
set :database, "postgresql://#{DB_CONFIG['username']}:#{DB_CONFIG['password']}@#{DB_CONFIG['host']}:#{DB_CONFIG['port']}/#{DB_CONFIG['database']}"

get '/' do
  @groups = Group.order("created_at DESC")
  slim :index
end

post '/' do
  Group.create(:name => params[:name], :token => params[:token])
  @groups = Group.order("created_at DESC")
  slim :index
end

get '/groups/:group_id' do
  @group = Group.find params[:group_id]
  slim :group
end

get '/groups/:group_id/new_user' do
  @world_cup = Game.where(real: true).all
  slim :new_user
end

post '/groups/:group_id/new_user' do
  group = Group.find params[:group_id]
  if group.token != params[:token]
  	return "Sorry, wrong token!"
  end
  group.add_user_tips(params)
  "Thankyou #{params[:name]} to send your tips to #{params[:group_id]}}"
end
