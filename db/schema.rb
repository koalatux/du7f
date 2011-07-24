# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110724134822) do

  create_table "choices", :force => true do |t|
    t.string  "title"
    t.integer "poll_id"
  end

  add_index "choices", ["poll_id"], :name => "index_choices_on_poll_id"

  create_table "entries", :force => true do |t|
    t.integer "answer"
    t.integer "participant_id"
    t.integer "choice_id"
  end

  add_index "entries", ["participant_id", "choice_id"], :name => "index_entries_on_participant_id_and_choice_id", :unique => true

  create_table "participants", :force => true do |t|
    t.string   "name"
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["poll_id"], :name => "index_participants_on_poll_id"

  create_table "polls", :force => true do |t|
    t.string   "token"
    t.string   "admin_token"
    t.string   "author"
    t.string   "title"
    t.text     "description"
    t.integer  "poll_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "admin_email_address"
  end

  add_index "polls", ["token"], :name => "index_polls_on_token", :unique => true

end
