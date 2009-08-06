class CreateAgents < ActiveRecord::Migration
  def self.up
    create_table :agents do |t|
      t.column :name, :string
      t.column :hostname, :string
      t.column :port, :string
      t.column :authkey, :string
      t.timestamps
    end
    add_index :agents, :name
    add_index :agents, :hostname
  end

  def self.down
    drop_table :agents
  end
end
