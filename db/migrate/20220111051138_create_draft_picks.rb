class CreateDraftPicks < ActiveRecord::Migration[7.0]
  def change
    create_table :draft_picks, id: :uuid do |t|
      t.integer :round
      t.string :original_owner
      t.string :current_owner
      t.integer :year
      t.decimal :minimum_salary, precision: 7, scale: 2
      t.decimal :maximum_salary, precision: 7, scale: 2
      t.decimal :average_salary, precision: 7, scale: 2

      t.timestamps
    end

    add_index :draft_picks, [:year, :round, :original_owner],
      unique: true, name: 'draft_pick_upsert_index'
  end
end
