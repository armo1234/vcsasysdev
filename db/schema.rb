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

ActiveRecord::Schema.define(version: 20170606172617) do

  create_table "activities", force: :cascade do |t|
    t.string   "activity_name"
    t.decimal  "allocated_money"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "position_id"
  end

  create_table "admin_code", force: :cascade do |t|
    t.string "admin_code"
  end

  create_table "codes", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.string   "component_name"
    t.string   "description"
    t.decimal  "cost"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimations", force: :cascade do |t|
    t.decimal  "estimate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incomes", force: :cascade do |t|
    t.string   "description"
    t.decimal  "amount"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memos", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.decimal  "allocated_money"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "password_digest"
    t.boolean  "admin",                  default: false
    t.boolean  "email_confirmed",        default: true
    t.string   "confirm_token"
    t.string   "admin_code"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
