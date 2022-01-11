# == Schema Information
#
# Table name: draft_picks
#
#  id             :uuid             not null, primary key
#  round          :integer
#  original_owner :string
#  current_owner  :string
#  year           :integer
#  minimum_salary :decimal(7, 2)
#  maximum_salary :decimal(7, 2)
#  average_salary :decimal(7, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  draft_pick_upsert_index  (year,round,original_owner) UNIQUE
#

require 'rails_helper'

RSpec.describe DraftPick, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
