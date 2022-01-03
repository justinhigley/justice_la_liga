class League < ApplicationRecord
	has_many :teams, foreign_key: 'mfl_league_id', primary_key: 'mfl_id'
	has_many :players, ->(league) { unscope(:where).where("position IN (?)", league.player_positions) }

	def holdout_salary(position, player_count)
		return unless self.player_positions.include? position
		salaries = Player.where(position: position).joins(
			:contracts).order('salary DESC NULLS LAST').limit(
			player_count).pluck(:salary)
		holdout_amount = ( salaries.sum / salaries.size * 0.5 )
		return holdout_amount
	end

	def holdout_points(position, player_count)
		return unless self.player_positions.include? position
		points = Player.where(position: position).order(
			'ytd_score DESC NULLS LAST').limit(player_count).pluck(
			:ytd_score).last
		return points
	end

	def holdouts(position, player_count)
		return unless self.player_positions.include? position
		amount = holdout_salary(position, player_count)
		points = holdout_points(position, player_count)
		return Player.joins(:contracts).where(
			"position = ? AND ytd_score > ? AND salary < ? AND years_remaining > 1",
			position, points, amount)
	end

end
