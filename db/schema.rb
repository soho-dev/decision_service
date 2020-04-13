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

ActiveRecord::Schema.define(version: 20200413171638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.text "street", null: false
    t.text "unit_number"
    t.text "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "county", null: false
    t.bigint "decision_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["decision_request_id"], name: "index_addresses_on_decision_request_id"
  end

  create_table "applicants", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "encrypted_ssn", null: false
    t.string "encrypted_ssn_iv"
    t.float "income", null: false
    t.string "income_type"
    t.float "requested_loan_amount", null: false
    t.bigint "decision_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["decision_request_id"], name: "index_applicants_on_decision_request_id"
  end

  create_table "credit_reports", force: :cascade do |t|
    t.integer "credit_score"
    t.bigint "applicant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_credit_reports_on_applicant_id"
  end

  create_table "decision_requests", force: :cascade do |t|
    t.integer "application_id"
    t.string "decision"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decisions", force: :cascade do |t|
    t.string "rule_name"
    t.string "decision"
    t.string "message"
    t.bigint "decision_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["decision_request_id"], name: "index_decisions_on_decision_request_id"
  end

  create_table "mortgage_reports", force: :cascade do |t|
    t.integer "total_mortgage"
    t.integer "pending_mortgage"
    t.string "regular_in_payment"
    t.bigint "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_mortgage_reports_on_address_id"
  end

end
