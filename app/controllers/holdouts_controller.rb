class HoldoutsController < ApplicationController
	helper HoldoutsHelper
	def index
		@top_salaries = League.first.top_salary_all_positions
		@top_scores = League.first.top_scores_all_positions

		@holdout_salaries = League.first.holdout_salary_all_positions
		@holdout_points = League.first.holdout_points_all_positions
	end
end
