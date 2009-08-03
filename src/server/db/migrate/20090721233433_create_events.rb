class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :payload, :string
      t.column :staticentry_id, :string
      t.column :agent_id, :int
      t.column :loglevel, :int
      t.column :time, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
