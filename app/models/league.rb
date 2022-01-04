class League < ApplicationRecord
	has_many :teams, foreign_key: 'mfl_league_id', primary_key: 'mfl_id'
	has_many :contracts, foreign_key: 'mfl_league_id', primary_key: 'mfl_id'
	has_many :players, ->(league) { unscope(:where).where("position IN (?)", league.player_positions) }

	def holdout_salary(position, player_count)
		return unless self.player_positions.include? position
		salaries = Player
			.joins(:contracts)
			.where(position: position)
			.order('salary DESC NULLS LAST')
			.limit(player_count)
			.pluck(:salary)
		holdout_amount = ( salaries.sum / salaries.size * 0.5 )
		return holdout_amount
	end

	def holdout_salary_all_positions
		holdout_salary = {}
		holdout_salary["QB"] = holdout_salary("QB", 5)
		holdout_salary["RB"] = holdout_salary("RB", 10)
		holdout_salary["WR"] = holdout_salary("WR", 15)
		holdout_salary["TE"] = holdout_salary("TE", 5)
		return holdout_salary
	end

	def holdout_points(position, player_count)
		return unless self.player_positions.include? position
		points = Player
			.where(position: position)
			.order('ytd_score DESC NULLS LAST')
			.limit(player_count)
			.pluck(:ytd_score)
			.last
		return points
	end

	def holdout_points_all_positions
		holdout_points = {}
		holdout_points["QB"] = holdout_points("QB", 5)
		holdout_points["RB"] = holdout_points("RB", 10)
		holdout_points["WR"] = holdout_points("WR", 15)
		holdout_points["TE"] = holdout_points("TE", 5)
		return holdout_points
	end

	def holdouts(position, player_count)
		return unless self.player_positions.include? position
		amount = holdout_salary(position, player_count)
		points = holdout_points(position, player_count)
		return Player
			.joins(:contracts)
			.where("position = ? AND ytd_score > ? AND salary < ? AND years_remaining > 1",
							position, points, amount)
	end

	def top_salary(position, player_count)
		return unless self.player_positions.include? position
		return Player
			.joins(:contracts)
			.where("players.position = ?", position)
			.order('salary DESC NULLS LAST')
			.limit(player_count)
			.pluck(:name, :salary)
	end

	def top_salary_all_positions
		top_salary_players = {}
		top_salary_players["QB"] = top_salary("QB", 5)
		top_salary_players["WR"] = top_salary("WR", 15)
		top_salary_players["TE"] = top_salary("TE", 5)
		top_salary_players["RB"] = top_salary("RB", 10)
		return top_salary_players
	end

	def top_scores(position, player_count)
		return unless self.player_positions.include? position
		return Player
			.joins(:contracts)
			.where("players.position = ?", position)
			.order('ytd_score DESC NULLS LAST')
			.limit(player_count)
			.pluck(:name, :salary, :ytd_score, :years_remaining)
	end

	def top_scores_all_positions
		top_scores_players = {}
		top_scores_players["QB"] = top_scores("QB", 5)
		top_scores_players["WR"] = top_scores("WR", 15)
		top_scores_players["TE"] = top_scores("TE", 5)
		top_scores_players["RB"] = top_scores("RB", 10)
		return top_scores_players
	end

end
