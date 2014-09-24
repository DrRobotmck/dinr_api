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

ActiveRecord::Schema.define(version: 20140922201447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: true do |t|
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boros", force: true do |t|
    t.integer "identifier"
    t.string  "name"
  end

  create_table "cuisines", force: true do |t|
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cuisines_restaurants", id: false, force: true do |t|
    t.integer "cuisine_id",    null: false
    t.integer "restaurant_id", null: false
  end

  add_index "cuisines_restaurants", ["cuisine_id"], name: "index_cuisines_restaurants_on_cuisine_id", using: :btree
  add_index "cuisines_restaurants", ["restaurant_id"], name: "index_cuisines_restaurants_on_restaurant_id", using: :btree

  create_table "inspections", force: true do |t|
    t.date     "date_inspected"
    t.integer  "score"
    t.integer  "restaurant_id"
    t.integer  "action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspections_violations", id: false, force: true do |t|
    t.integer "inspection_id", null: false
    t.integer "violation_id",  null: false
  end

  add_index "inspections_violations", ["inspection_id"], name: "index_inspections_violations_on_inspection_id", using: :btree
  add_index "inspections_violations", ["violation_id"], name: "index_inspections_violations_on_violation_id", using: :btree

  create_table "restaurants", force: true do |t|
    t.integer  "camis"
    t.string   "dba"
    t.string   "building_number"
    t.string   "street_address"
    t.integer  "zip_code"
    t.string   "phone_number"
    t.string   "current_grade"
    t.date     "grade_date"
    t.integer  "boro_id"
    t.integer  "cuisine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "violations", force: true do |t|
    t.string   "code"
    t.boolean  "critical_violation"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
