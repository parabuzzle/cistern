class Logtype < ActiveRecord::Base
  has_and_belongs_to_many :agents
  has_many :staticentries
  has_many :events, :through => :staticentries
  
  #Validations
  validates_presence_of :name

  
  def add(agent)
    ActiveRecord::Base.connection.execute("insert into agents_logtypes (logtype_id,agent_id)values('#{self.id}','#{agent.id}')")
    return agent
  end
  
  def del
    static = self.staticentries
    static.each do |s|
      s.del
    end
    self.destory
  end
  
end
