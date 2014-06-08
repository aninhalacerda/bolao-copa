require 'sinatra'
require 'slim'
require 'sinatra/activerecord'
require 'yaml'
require 'sinatra-env'
require 'pry'

require './util.rb'
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
end

get '/groups/:group_id' do
  @world_cup = Game.where(real: true).all
  slim :new_user
end

post '/groups/:group_id' do
  user = User.create(:name => params[:name])
  tip = Tip.create(:user => user)

  binding.pry
  games = Util.extract_games_from_params(params)

  games.each_key do |number|
	game = games[number].to_a
	team1 = game.first
	team2 = game.last
	Game.create({first_team: team1.first,
				 second_team: team2.first,
				 first_team_score: team1.last,
				 second_team_score: team2.last,
				 number: number,
				 past: false,
				 real: false,
				 tip: tip})
  end
  "Thankyou #{params[:name]} to send your tips to #{params[:group_id]}}"
end
