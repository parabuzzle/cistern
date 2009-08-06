class AddDescriptionToLogtype < ActiveRecord::Migration
  def self.up
    add_column :logtypes, :description, :string
  end

  def self.down
    remove_column :logtypes, :description
  end
end
