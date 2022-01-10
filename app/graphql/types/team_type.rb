module Types
  class TeamType < Types::BaseObject
    field :id, ID, null: false
    field :mfl_year, String, null: true
    field :mfl_league_id, String, null: true
    field :mfl_id, String, null: true
    field :name, String, null: true
    field :owner_name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
