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

ActiveRecord::Schema.define(:version => 20100730021556) do

  create_table "meeting_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", :force => true do |t|
    t.string   "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",            :default => false
    t.text     "description"
    t.integer  "event_series_id"
    t.integer  "trainer_meeting_id"
    t.integer  "meeting_type_id"
    t.integer  "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.integer  "trainer_id"
    t.integer  "meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", :force => true do |t|
    t.time     "start_time"
    t.string   "title"
    t.boolean  "monday",     :default => false
    t.boolean  "tuesday",    :default => false
    t.boolean  "wednesday",  :default => false
    t.boolean  "thursday",   :default => false
    t.boolean  "friday",     :default => false
    t.boolean  "saturday",   :default => false
    t.boolean  "sunday",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainer_meetings", :force => true do |t|
    t.integer  "trainer_id"
    t.integer  "meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
