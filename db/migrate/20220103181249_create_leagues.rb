class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues, id: :uuid do |t|
      t.string :mfl_id
      t.string :name
      t.decimal :salary_cap, precision: 7, scale: 2
      t.string :base_url

      t.timestamps
    end

    add_index :leagues, :mfl_id, unique: true, name: 'league_mfl_id'
  end
end
