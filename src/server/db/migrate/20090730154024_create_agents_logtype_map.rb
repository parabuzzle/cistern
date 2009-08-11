class CreateAgentsLogtypeMap < ActiveRecord::Migration
  def self.up
    create_table :agents_logtypes, :id => false do |t|
      t.column :logtype_id, :int
      t.column :agent_id, :int
      t.timestamps
    end
    add_index :agents_logtypes, :logtype_id
    add_index :agents_logtypes, :agent_id
  end

  def self.down
    drop_table :agents_logtypes
  end
end
