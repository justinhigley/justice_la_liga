class AddScoresToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :ytd_score, :decimal, precision: 7, scale: 2
  end
end
