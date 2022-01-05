class TagsController < ApplicationController
	helper TagsHelper

	def index
		@tags = League.first.tag_calculations_all_positions
		@top_scores = League.first.top_scoring_expiring_all_positions
	end
end
