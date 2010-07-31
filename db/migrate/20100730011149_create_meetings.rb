class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.string   "title"
      t.datetime "starttime"
      t.datetime "endtime"
      t.boolean  "all_day",         :default => false
      t.text     "description"
      t.integer  "event_series_id"
      t.integer :trainer_meeting_id
      t.integer :meeting_type_id
      t.integer :time_slot_id
#      t.date :meeting_date
#      t.decimal :duration
      t.timestamps
    end
  end
  
  def self.down
    drop_table :meetings
  end
end
