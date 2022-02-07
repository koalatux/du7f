# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_07_210433) do

  create_table "choices", force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "poll_id"
    t.index ["poll_id"], name: "index_choices_on_poll_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "name", limit: 255
    t.text "comment"
    t.integer "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["poll_id"], name: "index_comments_on_poll_id"
  end

  create_table "entries", force: :cascade do |t|
    t.integer "answer"
    t.integer "participant_id"
    t.integer "choice_id"
    t.index ["choice_id"], name: "index_entries_on_choice_id"
    t.index ["participant_id"], name: "index_entries_on_participant_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["poll_id"], name: "index_participants_on_poll_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "token", limit: 255
    t.string "admin_token", limit: 255
    t.string "author", limit: 255
    t.string "title", limit: 255
    t.text "description"
    t.integer "poll_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "admin_email_address", limit: 255
    t.boolean "comments_allowed"
    t.datetime "close_at"
    t.index ["token"], name: "index_polls_on_token", unique: true
  end

end
