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

ActiveRecord::Schema[7.0].define(version: 2023_06_25_220203) do
  create_table "bans", force: :cascade do |t|
    t.string "user_id"
    t.string "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drafts", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "date"
    t.integer "limit"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_drafts_on_users_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "value"
    t.string "user_id"
    t.string "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "date"
    t.integer "limit"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "org_events", force: :cascade do |t|
    t.string "user_id"
    t.string "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "presales", force: :cascade do |t|
    t.string "user_id"
    t.string "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saves", force: :cascade do |t|
    t.string "user_id"
    t.string "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id"
    t.string "password"
    t.string "email"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bans", "users"
  add_foreign_key "bans", "users", column: "admin_id"
  add_foreign_key "evaluations", "events"
  add_foreign_key "evaluations", "users"
  add_foreign_key "org_events", "events"
  add_foreign_key "org_events", "users"
  add_foreign_key "presales", "events"
  add_foreign_key "presales", "users"
  add_foreign_key "saves", "events"
  add_foreign_key "saves", "users"
end
