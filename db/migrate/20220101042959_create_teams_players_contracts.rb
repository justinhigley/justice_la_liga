class CreateTeamsPlayersContracts < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'

    create_table :teams, id: :uuid do |t|

      t.string :mfl_year
      t.string :mfl_league_id
      t.string :mfl_id
      t.string :name
      t.string :owner_name
      t.timestamps
    end

    create_table :players, id: :uuid do |t|

      t.string :mfl_id
      t.string :position
      t.string :name
      t.string :team
      t.timestamps
    end

    create_table :contracts, id: :uuid do |t|

      t.string :mfl_player_id
      t.string :mfl_team_id
      t.string :mfl_league_id
      t.decimal :salary, precision: 7, scale: 2
      t.integer :years_remaining
      t.string :status
      t.timestamps
    end

    add_index :teams, [:mfl_league_id, :mfl_year, :mfl_id], unique: true, name: 'teams_upsert_index'
    add_index :players, :mfl_id, unique: true, name: 'player_mfl_id'
    add_index :contracts, [:mfl_league_id, :mfl_player_id], unique: true, name: 'contracts_upsert_index'
  end
end
