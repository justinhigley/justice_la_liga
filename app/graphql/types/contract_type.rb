module Types
  class ContractType < Types::BaseObject
    field :id, ID, null: false
    field :mfl_player_id, String, null: true
    field :mfl_team_id, String, null: true
    field :mfl_league_id, String, null: true
    field :salary, Float, null: true
    field :years_remaining, Integer, null: true
    field :status, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :player, Types::PlayerType, null: false
  end
end
