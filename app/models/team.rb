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

	def roster_salary
		players.roster.sum(:salary)
	end

	def injured_reserve_salary
		players.injured_reserve.sum(:salary) * 0.5
	end

	def taxi_salary
		players.taxi.sum(:salary) * 0.25
	end

	def total_salary
		roster_salary + injured_reserve_salary + taxi_salary
	end

	def salaries
		salary_hash = {"2021": [], "2022": [], "2023": [], "2024": [], "2025": [], "2026": []}
		salary_hash[:"2021"].push(future_salaries(0))
		salary_hash[:"2022"].push(future_salaries(1))
		salary_hash[:"2023"].push(future_salaries(2))
		salary_hash[:"2024"].push(future_salaries(3))
		salary_hash[:"2025"].push(future_salaries(4))
		salary_hash[:"2026"].push(future_salaries(5))
		return salary_hash
	end

	def future_salaries(years_away)
		players
			.pluck(:name, :years_remaining, :salary)
			.select {|player| player[1].to_i >= years_away}
			.map do |player|
				{
					name: player[0],
					years: player[1],
					salary: (player[2] * 1.2**years_away).round(2)
				}
			end
	end

end
