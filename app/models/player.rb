class Player < ApplicationRecord
	has_many :contracts, primary_key: 'mfl_id', foreign_key: 'mfl_player_id'

	scope :in_league, ->(league) { where("position IN (?)", league.player_positions )}
end
