class TeamsController < ApplicationController
	def index
		@teams = Team.all
	end

	def show
		@team = Team.find(params[:id])
		@salaries = @team.salaries
		@draft_picks = @team.draft_picks.order(:year, :round)
		@roster = @team.roster
	end
end
