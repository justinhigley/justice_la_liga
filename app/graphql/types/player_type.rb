module Types
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :mfl_id, String, null: true
    field :position, String, null: true
    field :name, String, null: true
    field :team, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
