class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.datetime :start_time, :end_time
      t.integer :event_type_id
      t.boolean :all_day, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
