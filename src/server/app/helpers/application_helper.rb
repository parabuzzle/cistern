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
    if USEMEMCACHE != true
      static = Staticentry.find(e.staticentry.id)
    else
      static = Staticentry.get_cache(e.staticentry.id)
    end
    entries = e.payload.split('/111/')
    hash = Hash.new
    entries.each do |m|
      map = m.split('/000/')
      hash.store('<<<' + map[0] + '>>>',map[1])
    end
    p = static.data
    hash.each do |key, val|
      p = p.gsub(key,val)
      p = p.gsub("\n", "<br/>")
    end
    return p
  end
  
  def filter_agent(results,agent_id)
    r = Array.new
    results.each do |result|
      if result.agent_id == agent_id
        r << result
      end
    end
    return r
  end
  def filter_logtype(results,logtype_id)
    r = Array.new
    results.each do |result|
      if result.logtype_id == logtype_id
        r << result
      end
    end
    return r
  end
  
  def filter_loglevel(results,loglevel_id)
    r = Array.new
    results.each do |result|
      if result.loglevel_id <= loglevel_id
        r << result
      end
    end
    return r
  end
  
end
