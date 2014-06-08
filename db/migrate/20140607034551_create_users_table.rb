class CreateUsersTable < ActiveRecord::Migration
  	def self.up
		create_table :users do |u|
			u.string :name
			u.integer :score
			u.belongs_to :group
			u.has_one :tip
			u.timestamps
		end
	end

	def self.down
		drop_table :users
	end
end
