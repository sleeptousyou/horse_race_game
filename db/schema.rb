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

ActiveRecord::Schema.define(version: 2019_07_15_225122) do

  create_table "ballots", force: :cascade do |t|
    t.integer "user_id"
    t.integer "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "betting_tickets", force: :cascade do |t|
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "list_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dividends", force: :cascade do |t|
    t.integer "list_id"
    t.integer "win"
    t.integer "quinella"
    t.integer "exacta"
    t.integer "trio"
    t.integer "trifecta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blucket_quinella"
    t.integer "bracket_quinella"
    t.integer "place1"
    t.integer "place2"
    t.integer "place3"
    t.integer "quinella_place1"
    t.integer "quinella_place2"
    t.integer "quinella_place3"
  end

  create_table "horses", force: :cascade do |t|
    t.string "race_name"
    t.integer "gate_number"
    t.string "horse_name"
    t.string "sex"
    t.integer "year"
    t.string "rider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "horse_number"
    t.integer "prize_number"
    t.integer "list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "race_name"
    t.boolean "thisweek"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.text "prediction"
    t.datetime "deadline"
  end

  create_table "marks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "total_get"
    t.float "recovery_rate"
    t.float "hit_ratio"
    t.integer "most_high_get"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "money", force: :cascade do |t|
    t.integer "user_id"
    t.integer "prize_number"
    t.integer "unused"
    t.integer "used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "user_id"
    t.integer "prize_number"
    t.integer "race_id"
    t.integer "price"
    t.integer "get"
    t.integer "betting_ticket"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "win"
    t.integer "quinella"
    t.integer "trio"
    t.integer "list_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "email"
    t.text "document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.integer "list_id"
    t.integer "win"
    t.integer "second"
    t.integer "third"
    t.integer "gate1"
    t.integer "gate2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recoveries", force: :cascade do |t|
    t.integer "list_id"
    t.integer "user_id"
    t.integer "sum_price"
    t.integer "sum_get"
    t.integer "hit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  create_table "selections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "prize_number"
    t.integer "win"
    t.integer "quinella"
    t.integer "trio"
    t.integer "betting_ticket"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
