class CreateLogtypes < ActiveRecord::Migration
  def self.up
    create_table :logtypes do |t|
      t.column :name, :string
      t.timestamps
    end
    add_index :logtypes, :name
  end

  def self.down
    drop_table :logtypes
  end
end
