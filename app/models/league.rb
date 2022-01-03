class League < ApplicationRecord
	has_many :teams, foreign_key: 'mfl_league_id', primary_key: 'mfl_id'
	has_many :contracts, through: :teams
	has_many :players, through: :teams
end
