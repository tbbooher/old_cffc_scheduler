class CreateTrainers < ActiveRecord::Migration
  def self.up
    create_table :trainers do |t|
      t.string :name
      t.text :description
      t.string :phone
      t.timestamps
    end
  end
  
  def self.down
    drop_table :trainers
  end
end
