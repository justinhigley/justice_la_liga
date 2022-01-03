# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_03_181249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "contracts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "mfl_player_id"
    t.string "mfl_team_id"
    t.string "mfl_league_id"
    t.decimal "salary", precision: 7, scale: 2
    t.integer "years_remaining"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mfl_league_id", "mfl_player_id"], name: "contracts_upsert_index", unique: true
  end

  create_table "leagues", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "mfl_id"
    t.string "name"
    t.decimal "salary_cap", precision: 7, scale: 2
    t.string "base_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mfl_id"], name: "league_mfl_id", unique: true
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "mfl_id"
    t.string "position"
    t.string "name"
    t.string "team"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "ytd_score", precision: 7, scale: 2
    t.index ["mfl_id"], name: "player_mfl_id", unique: true
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "mfl_year"
    t.string "mfl_league_id"
    t.string "mfl_id"
    t.string "name"
    t.string "owner_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mfl_league_id", "mfl_year", "mfl_id"], name: "teams_upsert_index", unique: true
  end

end
