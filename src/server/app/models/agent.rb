class Agent < ActiveRecord::Base
  acts_as_ferret :fields => [:hostname, :name, :port]
  
  has_and_belongs_to_many :logtypes, :join_table => :agents_logtypes
  has_many :events
  
  #Validations
  validates_presence_of :hostname, :port, :name
  #validates_format_of :hostname, :with => /([A-Z0-9-]+\.)+[A-Z]{2,4}$/i
  validates_uniqueness_of :name
  
  def add_logtype(logtype)
    if self.logtypes.find_by_logtype_id('logtype.id') == nil
      ActiveRecord::Base.connection.execute("insert into agents_logtypes (logtype_id,agent_id)values('#{logtype.id}','#{self.id}')")
    end
    return logtype
  end
  
  def remove_logtype(logtype)
    if self.logtypes.find_by_logtype_id('logtype.id') != nil
      ActiveRecord::Base.connection.execute("delete from agents_logtypes where logtype_id = '#{logtype.id}' and agent_id = '#{self.id}'")
    end
    return logtype
  end
  
  def logtype_member?(logtype)
    flag = 0
    self.logtypes.each do |log|
      if log.id == logtype.id
        flag = 1
      end
    end
    return flag
  end

  
end
