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

ActiveRecord::Schema.define(version: 20180511014116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_registrations", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_requirements", force: :cascade do |t|
    t.integer "event_id"
    t.string "type"
    t.string "description"
    t.decimal "amount", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_submissions", force: :cascade do |t|
    t.integer "event_requirement_id"
    t.integer "event_registration_id"
    t.integer "submitter_id"
    t.integer "approver_id"
    t.datetime "approved_at"
    t.text "file_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "unit_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guardianships", force: :cascade do |t|
    t.integer "guardian_id"
    t.integer "guardee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "unit_id"
    t.boolean "active", default: true
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "type"
    t.string "number"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "type"
    t.string "rank"
    t.string "phone"
    t.boolean "share_email"
    t.boolean "share_phone"
    t.string "email", default: ""
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
