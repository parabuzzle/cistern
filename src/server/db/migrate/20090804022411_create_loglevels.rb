class CreateLoglevels < ActiveRecord::Migration
  def self.up
    create_table :loglevels do |t|
      t.column :name, :string
      t.timestamps
    end
     Loglevel.create :name => "FATAL", :id => 1
     Loglevel.create :name => "ERROR", :id => 2
     Loglevel.create :name => "WARN", :id => 3
     Loglevel.create :name => "INFO", :id => 4
     Loglevel.create :name => "DEBUG", :id => 5
     Loglevel.create :name => "UNKNOWN", :id => 6
  end

  def self.down
    drop_table :loglevels
  end
end
