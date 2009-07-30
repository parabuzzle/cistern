class CreateStaticentries < ActiveRecord::Migration
  def self.up
    create_table :staticentries, :id => false do |t|
      t.column :id, :string, :null => false
      #t.column :hash_key, :string, :null => false
      t.column :logtype_id, :int
      t.column :data, :text
      t.column :agent_id, :int
      t.timestamps
    end
    #add_index :staticentries, :hash_key
    #add_index :staticentries, :agent_id 
    #unless ActiveRecord::Base.configurations[ENV['RAILS_ENV']]['adapter'] != 'mysql'
    #      execute "ALTER TABLE staticentries ADD PRIMARY KEY (id)"
    #end
  end

  def self.down
    drop_table :staticentries
  end
end
