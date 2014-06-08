class CreateGroupTable < ActiveRecord::Migration
	def self.up
		create_table :groups do |g|
			g.string :name
			g.string :token
			g.timestamps
		end
	end

	def self.down
		drop_table :groups
	end
end
