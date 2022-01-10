# == Schema Information
#
# Table name: teams
#
#  id            :uuid             not null, primary key
#  mfl_year      :string
#  mfl_league_id :string
#  mfl_id        :string
#  name          :string
#  owner_name    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  teams_upsert_index  (mfl_league_id,mfl_year,mfl_id) UNIQUE
#

class Team < ApplicationRecord
	belongs_to :league, foreign_key: 'mfl_league_id', primary_key: 'mfl_id'
	has_many :players, foreign_key: 'mfl_team_id', primary_key: 'mfl_id'
end
