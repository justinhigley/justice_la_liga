module Types
  class QueryType < Types::BaseObject
    field :teams,
          [Types::TeamType],
          null: false,
          description: "Returns a list of teams"

    def teams
      Team.all
    end
  end
end
