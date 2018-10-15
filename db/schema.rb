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

ActiveRecord::Schema.define(version: 2018_10_13_112454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "plperl"
  enable_extension "plpgsql"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_table "achievables", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "description"
    t.string "program_code"
    t.integer "parent_achievable_id"
    t.integer "requirable_id"
    t.integer "param"
    t.integer "precursor_id"
    t.integer "ordinal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "achievements", force: :cascade do |t|
    t.integer "user_id"
    t.integer "achievable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "earned_at"
    t.string "approved_by"
    t.date "awarded_at"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "application_data", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_library_items", force: :cascade do |t|
    t.string "name"
    t.integer "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "parent_id"
  end

  create_table "event_registrations", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.boolean "attended"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_requirements", force: :cascade do |t|
    t.integer "event_id"
    t.string "type"
    t.string "description"
    t.integer "amount_youth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "due_at"
    t.integer "document_library_item_id"
    t.integer "audience", default: 0
    t.boolean "required", default: true
    t.integer "amount_adult"
    t.boolean "waive_transaction_fees", default: false
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
    t.datetime "due_at"
    t.boolean "waived", default: false
    t.string "stripe_charge_id"
    t.string "cc_last_4"
    t.string "cc_expiration_month"
    t.string "cc_expiration_year"
    t.integer "payment_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "unit_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "registration_closes_at"
    t.boolean "require_registration", default: false
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "banner_image_url"
    t.text "description"
    t.integer "minimum_age"
    t.boolean "published", default: false
    t.string "event_type"
  end

  create_table "guardianships", force: :cascade do |t|
    t.integer "guardian_id"
    t.integer "guardee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magic_links", force: :cascade do |t|
    t.string "magic_linkable_type"
    t.string "magic_linkable_id"
    t.string "recipient"
    t.string "token"
    t.integer "sender_id"
    t.datetime "expires_at"
    t.datetime "redeemed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "unit_id"
    t.boolean "active", default: true
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_position_id"
    t.text "notes"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "author_id"
    t.text "body"
    t.string "messagable_type"
    t.integer "messagable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pingees"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "user_id"
    t.string "last4"
    t.integer "expiration_month"
    t.integer "expiration_year"
    t.string "brand"
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "external_id"
    t.integer "amount"
    t.string "brand"
    t.string "last4"
    t.integer "expiration_month"
    t.integer "expiration_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prototype_positions", force: :cascade do |t|
    t.string "program_code"
    t.string "audience"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "exclusive", default: true
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string "display_name"
    t.string "internal_name"
    t.string "sku"
    t.string "frequency"
    t.integer "price"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unit_positions", force: :cascade do |t|
    t.string "audience"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_id"
    t.boolean "exclusive", default: true
  end

  create_table "units", force: :cascade do |t|
    t.string "type"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "program_code"
    t.string "chartering_organization_name"
    t.integer "chartering_organization_representatie_id"
    t.date "charter_expires_at"
    t.string "state"
    t.string "council"
    t.string "district"
    t.string "stripe_user_id"
    t.integer "primary_wiki_article_id"
    t.string "time_zone"
    t.date "subscription_expires_at"
    t.integer "subscription_plan_id"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer "user_id"
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "type"
    t.string "phone"
    t.boolean "share_email"
    t.boolean "share_phone"
    t.boolean "active", default: true
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
    t.integer "rank_id"
    t.string "nickname"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.date "date_of_birth"
    t.string "post_nominal"
    t.string "stripe_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wiki_articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
