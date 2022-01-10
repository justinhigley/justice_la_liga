# == Schema Information
#
# Table name: leagues
#
#  id               :uuid             not null, primary key
#  mfl_id           :string
#  name             :string
#  salary_cap       :decimal(7, 2)
#  base_url         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  player_positions :string           is an Array
#
# Indexes
#
#  league_mfl_id  (mfl_id) UNIQUE
#

require "test_helper"

class LeagueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
