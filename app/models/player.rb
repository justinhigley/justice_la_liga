# == Schema Information
#
# Table name: players
#
#  id              :uuid             not null, primary key
#  mfl_id          :string
#  position        :string
#  name            :string
#  team            :string
#  mfl_team_id     :string
#  salary          :decimal(7, 2)
#  years_remaining :integer
#  status          :string
#  ytd_score       :decimal(7, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  player_mfl_id  (mfl_id) UNIQUE
#

class Player < ApplicationRecord
	belongs_to :team, foreign_key: 'mfl_team_id', primary_key: 'mfl_id'

	scope :in_league, ->(league) { where("position IN (?)", league.player_positions )}
end
