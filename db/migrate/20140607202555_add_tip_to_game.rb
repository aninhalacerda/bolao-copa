class AddTipToGame < ActiveRecord::Migration
  def self.up
  	drop_table :games
	create_table :games do |g|
		g.string :first_team
		g.string :second_team
		g.integer :first_team_score
		g.integer :second_team_score
		g.integer :number
		g.boolean :past
		g.boolean :real
		g.belongs_to :tip
		g.timestamps
	end
	end

	def self.down
		drop_table :games
	end
end
