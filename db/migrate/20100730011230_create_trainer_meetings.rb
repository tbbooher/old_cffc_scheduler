class CreateTrainerMeetings < ActiveRecord::Migration
  def self.up
    create_table :trainer_meetings do |t|
      t.integer :trainer_id
      t.integer :meeting_id
      t.timestamps
    end
  end

  def self.down
    drop_table :trainer_meetings
  end
end
