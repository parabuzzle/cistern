class AddLogtypeToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :logtype_id, :int
  end

  def self.down
    remove_column :events, :logtype_id
  end
end

