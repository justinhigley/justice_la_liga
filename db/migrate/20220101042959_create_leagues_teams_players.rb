class CreateLeaguesTeamsPlayers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'

    create_table :leagues, id: :uuid do |t|
      t.string  :mfl_id
      t.string  :name
      t.decimal :salary_cap, precision: 7, scale: 2
      t.string  :base_url
      t.string  :player_positions, array: true
      t.timestamps
    end

    create_table :teams, id: :uuid do |t|

      t.string :mfl_year
      t.string :mfl_league_id
      t.string :mfl_id
      t.string :name
      t.string :owner_name
      t.timestamps
    end

    create_table :players, id: :uuid do |t|

      t.string  :mfl_id
      t.string  :position
      t.string  :name
      t.string  :team
      t.string  :mfl_team_id
      t.decimal :salary, precision: 7, scale: 2
      t.integer :years_remaining
      t.string  :status
      t.decimal :ytd_score, precision: 7, scale: 2
      t.timestamps
    end

    add_index :leagues, :mfl_id, unique: true, name: 'league_mfl_id'
    add_index :teams,   :mfl_id, unique: true, name: 'team_mfl_id'
    add_index :players, :mfl_id, unique: true, name: 'player_mfl_id'
  end
end
