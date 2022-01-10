# == Schema Information
#
# Table name: contracts
#
#  id              :uuid             not null, primary key
#  mfl_player_id   :string
#  mfl_team_id     :string
#  mfl_league_id   :string
#  salary          :decimal(7, 2)
#  years_remaining :integer
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  contracts_upsert_index  (mfl_league_id,mfl_player_id) UNIQUE
#

require "test_helper"

class ContractTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
