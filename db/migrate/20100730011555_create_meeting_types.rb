class CreateMeetingTypes < ActiveRecord::Migration
  def self.up
    create_table :meeting_types do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :meeting_types
  end
end
