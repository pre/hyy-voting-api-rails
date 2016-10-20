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

ActiveRecord::Schema.define(version: 20161020132240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alliances", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "election_id",     null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "faculty_id"
    t.integer  "department_id"
    t.integer  "numbering_order"
    t.string   "short_name",      null: false
    t.integer  "coalition_id",    null: false
    t.index ["coalition_id"], name: "index_alliances_on_coalition_id", using: :btree
  end

  create_table "candidates", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "alliance_id",      null: false
    t.string   "firstname",        null: false
    t.string   "lastname",         null: false
    t.integer  "candidate_number"
    t.string   "candidate_name"
  end

  create_table "coalitions", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "numbering_order"
    t.integer  "election_id",     null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["election_id"], name: "index_coalitions_on_election_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "code",       null: false
    t.integer  "faculty_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_departments_on_code", unique: true, using: :btree
  end

  create_table "elections", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "faculty_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "department_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_faculties_on_code", unique: true, using: :btree
  end

  create_table "immutable_votes", force: :cascade do |t|
    t.integer  "candidate_id", null: false
    t.integer  "election_id",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["candidate_id"], name: "index_immutable_votes_on_candidate_id", using: :btree
    t.index ["election_id"], name: "index_immutable_votes_on_election_id", using: :btree
  end

  create_table "mutable_votes", force: :cascade do |t|
    t.integer  "voter_id",     null: false
    t.integer  "candidate_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "election_id",  null: false
    t.index ["voter_id", "election_id"], name: "index_mutable_votes_on_voter_id_and_election_id", unique: true, using: :btree
  end

  create_table "voters", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "email"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "faculty_id"
    t.string   "ssn",               null: false
    t.string   "student_number"
    t.integer  "start_year"
    t.integer  "extent_of_studies"
    t.string   "phone"
    t.integer  "department_id"
    t.index ["email"], name: "index_voters_on_email", using: :btree
    t.index ["ssn"], name: "index_voters_on_ssn", unique: true, using: :btree
  end

  create_table "voting_rights", force: :cascade do |t|
    t.integer  "election_id",                 null: false
    t.integer  "voter_id",                    null: false
    t.boolean  "used",        default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["election_id"], name: "index_voting_rights_on_election_id", using: :btree
    t.index ["voter_id", "election_id"], name: "index_voting_rights_on_voter_id_and_election_id", unique: true, using: :btree
    t.index ["voter_id"], name: "index_voting_rights_on_voter_id", using: :btree
  end

  add_foreign_key "alliances", "coalitions"
  add_foreign_key "alliances", "departments"
  add_foreign_key "alliances", "elections"
  add_foreign_key "alliances", "faculties"
  add_foreign_key "candidates", "alliances"
  add_foreign_key "departments", "faculties"
  add_foreign_key "elections", "departments"
  add_foreign_key "elections", "faculties"
  add_foreign_key "immutable_votes", "candidates"
  add_foreign_key "immutable_votes", "elections"
  add_foreign_key "mutable_votes", "candidates"
  add_foreign_key "mutable_votes", "elections"
  add_foreign_key "mutable_votes", "voters"
  add_foreign_key "voters", "departments"
  add_foreign_key "voters", "faculties"
  add_foreign_key "voting_rights", "elections"
  add_foreign_key "voting_rights", "voters"
end
