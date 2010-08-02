class CreateTimeSlots < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.time :start_time
      t.string :title
      t.integer :event_type_id      
      t.boolean :monday, :default => false
      t.boolean :tuesday, :default => false
      t.boolean :wednesday, :default => false
      t.boolean :thursday, :default => false
      t.boolean :friday, :default => false
      t.boolean :saturday, :default => false
      t.boolean :sunday, :default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :time_slots
  end
end
