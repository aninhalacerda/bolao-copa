class User < ActiveRecord::Base
	belongs_to :group
	has_one :tip
end