class Player < ApplicationRecord
	has_many :contracts, primary_key: 'mfl_id', foreign_key: 'mfl_player_id'
end
