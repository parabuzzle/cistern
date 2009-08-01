class Staticentry < ActiveRecord::Base
  has_many :events
  belongs_to :logtype
  
  #TODO: Make the id include the logtype to prevent hash collision cross logtypes
  
  def before_create 
    if Staticentry.find_by_id(Digest::MD5.hexdigest(self.data)) != nil 
      return false
    end
    self.id = Digest::MD5.hexdigest(self.data)
  end
  
end
