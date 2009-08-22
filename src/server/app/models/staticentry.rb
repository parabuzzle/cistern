class Staticentry < ActiveRecord::Base
  acts_as_ferret 
  acts_as_cached :ttl => 4.hours
  has_many :events
  belongs_to :logtype
  has_many :loglevels, :through => :entries
  
  def before_create 
    if Staticentry.find_by_id(Digest::MD5.hexdigest(self.data + self.logtype_id.to_s)) != nil 
      return false
    end
    self.id = Digest::MD5.hexdigest(self.data + self.logtype_id.to_s)
  end
  
  def del
    events = self.events
    event.each do |e|
      e.destory
    end
    self.destroy
  end
  
end
