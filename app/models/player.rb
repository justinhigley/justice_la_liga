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
	belongs_to :team,
		foreign_key: 'mfl_team_id',
		primary_key: 'mfl_id',
		optional: true

	scope :free_agents, -> { where(status: nil) }
	scope :expiring, -> { where('salary IS NOT NULL AND years_remaining < 2') }
	scope :injured_reserve, -> { where(status: "INJURED_RESERVE") }
	scope :roster, -> { where(status: "ROSTER") }
	scope :taxi, -> { where(status: "TAXI") }

	def cap_cost
		multiplier = {
			ROSTER: 1.0,
			INJURED_RESERVE: 0.5,
			TAXI: 0.25
		}
		salary * multiplier[status.to_sym]
	end

	def salaries
		salaries = Array.new(years_remaining || 1) { |i| i }
		salaries.map { |i| 1.2**i * salary }
	end
end
