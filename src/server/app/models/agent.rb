class Agent < ActiveRecord::Base
  
  has_and_belongs_to_many :logtypes, :join_table => :agents_logtypes
  has_many :events
  
  #Validations
  validates_presence_of :hostname, :port
  validates_format_of :hostname, :with => /([A-Z0-9-]+\.)+[A-Z]{2,4}$/i
  
  
end
