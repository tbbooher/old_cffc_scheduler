class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title, :url
      t.datetime :starttime, :endtime
      t.boolean :all_day, :default => false
      t.integer :event_type_id
      t.integer :time_slot_id
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
