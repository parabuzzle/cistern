class Agent < ActiveRecord::Base
  has_and_belongs_to_many :logtypes, :join_table => :agents_logtypes
  has_many :events
end
