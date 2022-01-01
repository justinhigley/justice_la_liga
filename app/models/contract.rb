class Contract < ApplicationRecord
	belongs_to :team, foreign_key: 'mfl_team_id', primary_key: 'mfl_id'
	has_one :player, foreign_key: 'mfl_id', primary_key: 'mfl_player_id'
end
