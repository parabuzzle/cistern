# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #Return events array with payload field populated with full event
  def rebuildevents(events)
    @events = Array.new
    events.each do |e|
      e.payload = rebuildevent(e)
      @events << e
    end
    return @events
  end
  
  #Return a string of replaced static entry keys based on event's payload
  def rebuildevent(e)
    static = e.staticentry
    entries = e.payload.split(',')
    hash = Hash.new
    entries.each do |m|
      map = m.split('=')
      hash.store('<<<' + map[0] + '>>>',map[1])
    end
    p = static.data
    hash.each do |key, val|
      p = p.gsub(key,val)
    end
    return p
  end
  
end
