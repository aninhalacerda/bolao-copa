require './util.rb'

class Group < ActiveRecord::Base
	has_many :users, dependent: :destroy

	def add_user_tips(params)
	  user = User.create(name: params[:name], group: self, score: 0)
  	  tip = Tip.create(user: user)

      games = Util.extract_games_from_params(params)

      games.each_key do |number|
	    game = games[number].to_a
	    team1 = game.first
	    team2 = game.last
	    Game.create({first_team: team1.first, second_team: team2.first,
	    		   first_team_score: team1.last, second_team_score: team2.last,
				   number: number, real: false, tip: tip})
      end
	end

	def users
      User.where(group_id: self.id).order('score DESC')
    end
end