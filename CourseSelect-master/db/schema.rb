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

ActiveRecord::Schema.define(version: 20170103055422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arranges", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "classtime_id"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "arranges", ["classroom_id"], name: "index_arranges_on_classroom_id", using: :btree
  add_index "arranges", ["classtime_id"], name: "index_arranges_on_classtime_id", using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.string   "campus"
    t.string   "volume"
    t.string   "building"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classtimes", force: :cascade do |t|
    t.string   "weekday"
    t.integer  "phase"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.text     "content",                       null: false
    t.boolean  "teacher",       default: false
    t.integer  "up",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "comments", ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "course_code"
    t.string   "course_type"
    t.string   "teaching_type"
    t.string   "exam_type"
    t.string   "credit"
    t.integer  "limit_num"
    t.integer  "student_num",   default: 0
    t.string   "class_room"
    t.string   "course_time"
    t.string   "course_week"
    t.integer  "teacher_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "open",          default: false
    t.integer  "status",        default: 0
    t.string   "campus",        default: "西区"
  end

  create_table "discussions", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "title",      null: false
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "discussions", ["course_id"], name: "index_discussions_on_course_id", using: :btree
  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "grades", ["course_id"], name: "index_grades_on_course_id", using: :btree
  add_index "grades", ["user_id"], name: "index_grades_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "num"
    t.string   "major"
    t.string   "department"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.boolean  "teacher",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
