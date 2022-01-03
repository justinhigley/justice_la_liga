class League < ApplicationRecord
	has_many :teams, foreign_key: 'mfl_league_id', primary_key: 'mfl_id'
	has_many :players, ->(league) { unscope(:where).where("position IN (?)", league.player_positions) }
end
