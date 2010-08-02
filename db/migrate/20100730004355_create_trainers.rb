class CreateTrainers < ActiveRecord::Migration
  def self.up
    create_table :coachs do |t|
      t.string :name
      t.text :description
      t.string :phone
      t.timestamps
    end
  end
  
  def self.down
    drop_table :coachs
  end
end
