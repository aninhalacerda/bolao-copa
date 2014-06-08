class Util
	def self.extract_games_from_params(params)
	  games_hash = {}
	  params.each do |param|
	    if match = param.first.match(/(^[a-zA-Z ]+)([0-9]+)/i)
	      team, number = match.captures
	      games_hash[number] ||= {}
	      games_hash[number].merge!({team => param.last})
	    end
	  end
	  games_hash
	end
end