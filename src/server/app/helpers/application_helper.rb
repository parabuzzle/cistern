# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def rebuildevents(events)
    @events = Array.new
    events.each do |e|
      static = e.staticentry
      entries = e.payload.split(',')
      hash = Hash.new
      entries.each do |m|
        map = m.split('=')
        hash.store('<<<' + map[0] + '>>>',map[1])
      end
      e.payload = static.data
      hash.each do |key, val|
        e.payload = e.payload.gsub(key,val)
      end
      @events << e
    end
    return @events
  end
  
  def displaylevel(level)
    if level == 0
      level = "FATAL"
    elsif level == 1
      level = "ERROR"
    elsif level == 2
      level = "WARN"
    elsif level == 3
      level = "INFO"
    elsif level == 4
      level = "DEBUG"
    else
      level = "UNKNOWN"
    end
    return level
  end
  
end
