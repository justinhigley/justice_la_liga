class AddPlayerPositionsToLeagues < ActiveRecord::Migration[7.0]
  def change
    add_column :leagues, :player_positions, :string, array: true
  end
end
