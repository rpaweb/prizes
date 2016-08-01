# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160801093553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prizes", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "desc",       null: false
    t.string   "photo",      null: false
    t.integer  "amount",     null: false
    t.integer  "rule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "prizes", ["name", "rule_id"], name: "index_prizes_on_name_and_rule_id", using: :btree
  add_index "prizes", ["rule_id"], name: "index_prizes_on_rule_id", using: :btree

  create_table "rules", force: :cascade do |t|
    t.string   "policy",     null: false
    t.integer  "specific"
    t.integer  "multipleof"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscribers", ["email"], name: "index_subscribers_on_email", using: :btree

  create_table "temporal_prizes", force: :cascade do |t|
    t.integer "prize_id"
    t.string  "prize_name"
  end

  add_index "temporal_prizes", ["prize_id", "prize_name"], name: "index_temporal_prizes_on_prize_id_and_prize_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "winners", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.integer  "prize_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "winners", ["prize_id"], name: "index_winners_on_prize_id", using: :btree
  add_index "winners", ["subscriber_id", "prize_id"], name: "index_winners_on_subscriber_id_and_prize_id", using: :btree
  add_index "winners", ["subscriber_id"], name: "index_winners_on_subscriber_id", using: :btree

  add_foreign_key "prizes", "rules"
  add_foreign_key "winners", "prizes"
  add_foreign_key "winners", "subscribers"
end
