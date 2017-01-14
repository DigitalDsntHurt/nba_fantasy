# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170114002838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "year_of_birth"
    t.string   "position_br"
    t.string   "position_dk"
    t.string   "current_team"
    t.text     "team_history"
    t.float    "points_season_avg"
    t.float    "points_career_avg"
    t.float    "three_pt_shots_made_season_avg"
    t.float    "three_pt_shots_made_career_avg"
    t.float    "assists_season_avg"
    t.float    "assists_career_avg"
    t.float    "offensive_rebounds_season_avg"
    t.float    "defensive_rebounds_season_avg"
    t.float    "offensive_rebounds_career_avg"
    t.float    "defensive_rebounds_career_avg"
    t.float    "steals_season_avg"
    t.float    "steals_career_avg"
    t.float    "blocks_season_avg"
    t.float    "blocks_career_avg"
    t.float    "turnovers_season_avg"
    t.float    "turnovers_career_avg"
    t.boolean  "active"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "team_years", force: :cascade do |t|
    t.string   "year"
    t.string   "team"
    t.integer  "wins"
    t.integer  "losses"
    t.string   "win_percentage"
    t.float    "offensive_rating"
    t.float    "defensive_rating"
    t.string   "season_outcome"
    t.string   "team_url"
    t.string   "team_home_url"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
