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
#  team_mfl_id  (mfl_id) UNIQUE
#

require "test_helper"

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
