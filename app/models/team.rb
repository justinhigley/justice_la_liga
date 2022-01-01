class Team < ApplicationRecord
	has_many :contracts, primary_key: 'mfl_id', foreign_key: 'mfl_team_id'
	has_many :players, through: :contracts
end
