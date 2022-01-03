class Team < ApplicationRecord
	belongs_to :league, foreign_key: 'mfl_league_id', primary_key: 'mfl_id'
	has_many :contracts, primary_key: 'mfl_id', foreign_key: 'mfl_team_id'
	has_many :players, through: :contracts
end
