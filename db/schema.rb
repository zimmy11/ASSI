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

ActiveRecord::Schema[7.0].define(version: 2023_06_29_131603) do
  create_table "bans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_bans_on_admin_id"
    t.index ["user_id"], name: "index_bans_on_user_id"
  end

  create_table "drafts", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "date"
    t.integer "limit"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_drafts_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_evaluations_on_event_id"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.string "date"
    t.integer "limit"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "presales_left"
    t.float "avgvalue"
  end

  create_table "org_events", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_org_events_on_event_id"
    t.index ["user_id"], name: "index_org_events_on_user_id"
  end

  create_table "presales", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_presales_on_event_id"
    t.index ["user_id"], name: "index_presales_on_user_id"
  end

  create_table "saves", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_saves_on_event_id"
    t.index ["user_id"], name: "index_saves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bans", "users", column: "admin_id"
  add_foreign_key "evaluations", "events"
  add_foreign_key "org_events", "events"
  add_foreign_key "presales", "events"
  add_foreign_key "saves", "events"
end
