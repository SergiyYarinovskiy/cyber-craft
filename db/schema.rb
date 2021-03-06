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

ActiveRecord::Schema.define(version: 20160510191907) do

  create_table "builds", force: :cascade do |t|
    t.integer  "session_id"
    t.string   "started_by"
    t.datetime "build_created_at"
    t.string   "summary_status"
    t.integer  "duration"
    t.integer  "worker_time"
    t.integer  "bundle_time"
    t.integer  "num_workers"
    t.string   "branch"
    t.string   "commit_id"
    t.integer  "started_tests_count"
    t.integer  "passed_tests_count"
    t.integer  "failed_tests_count"
    t.integer  "pending_tests_count"
    t.integer  "skipped_tests_count"
    t.integer  "error_tests_count"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
