class CreateTimeSlots < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.time :start_time
      t.integer  "day"
      t.timestamps
    end
  end
  
  def self.down
    drop_table :time_slots
  end
end
