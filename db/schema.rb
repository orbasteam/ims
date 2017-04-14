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

ActiveRecord::Schema.define(version: 20170413154117) do

  create_table "activities", force: :cascade do |t|
    t.integer  "interviewee_id", limit: 4
    t.string   "content",        limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "educations", force: :cascade do |t|
    t.integer "interviewee_id", limit: 4
    t.string  "name",           limit: 255
    t.string  "department",     limit: 255
    t.boolean "graduated"
    t.integer "school_type",    limit: 4
  end

  create_table "experiences", force: :cascade do |t|
    t.integer "interviewee_id", limit: 4
    t.string  "name",           limit: 255
    t.string  "title",          limit: 255
    t.string  "period",         limit: 255
    t.string  "seniority",      limit: 255
    t.integer "salary",         limit: 4
    t.string  "reason",         limit: 255
  end

  create_table "families", force: :cascade do |t|
    t.integer  "interviewee_id", limit: 4
    t.string   "title",          limit: 255
    t.string   "name",           limit: 255
    t.string   "job",            limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "interviewees", force: :cascade do |t|
    t.string   "name",                      limit: 255
    t.integer  "gender",                    limit: 4
    t.string   "number",                    limit: 255
    t.string   "email",                     limit: 255
    t.string   "phone",                     limit: 255
    t.integer  "position_id",               limit: 4
    t.datetime "interview_at"
    t.string   "note",                      limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "status",                    limit: 4
    t.string   "resume",                    limit: 255
    t.string   "name_en",                   limit: 255
    t.date     "birthday"
    t.string   "native_place",              limit: 255
    t.string   "id_number",                 limit: 255
    t.string   "blood_type",                limit: 255
    t.string   "communicate_address",       limit: 255
    t.string   "communicate_phone",         limit: 255
    t.string   "residence_address",         limit: 255
    t.string   "residence_phone",           limit: 255
    t.boolean  "over_time"
    t.boolean  "marriage"
    t.integer  "military",                  limit: 4
    t.boolean  "health"
    t.boolean  "genetic_disease"
    t.string   "genetic_disease_note",      limit: 255
    t.boolean  "nociceptive_disease"
    t.string   "nociceptive_disease_note",  limit: 255
    t.boolean  "other_disease"
    t.string   "other_disease_note",        limit: 255
    t.string   "expertise",                 limit: 255
    t.string   "hobby",                     limit: 255
    t.integer  "chinese",                   limit: 4
    t.integer  "taiwanese",                 limit: 4
    t.integer  "hakka",                     limit: 4
    t.integer  "english",                   limit: 4
    t.integer  "japanese",                  limit: 4
    t.date     "onboard_date"
    t.integer  "wish_salary",               limit: 4
    t.string   "relatives",                 limit: 255
    t.string   "other_language_familiar",   limit: 255
    t.string   "other_language_unfamiliar", limit: 255
    t.string   "token",                     limit: 255
    t.boolean  "finish_edit",                           default: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "supervisors", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "department",     limit: 255
    t.string   "title",          limit: 255
    t.string   "phone",          limit: 255
    t.string   "contact_time",   limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "interviewee_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
