class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :payload, :string
      t.column :staticentry_id, :string
      t.column :agent_id, :int
      t.column :loglevel_id, :int
      t.column :logtype_id, :int
      t.column :etime, :float
      t.timestamps
    end
    add_index :events, :logtype_id
    add_index :events, :loglevel_id
    add_index :events, :etime
    add_index :events, :agent_id
    add_index :events, :staticentry_id
  end

  def self.down
    drop_table :events
  end
end
