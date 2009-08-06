module SearchHelper
  
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
