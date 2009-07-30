class CreateAgentsLogtypeMap < ActiveRecord::Migration
  def self.up
    create_table :agents_logtypes do |t|
      t.column :logtype_id, :int
      t.column :agent_id, :int
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
