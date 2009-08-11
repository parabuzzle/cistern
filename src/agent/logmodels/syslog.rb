module SysLogModel
  
  def get_payload(string)
    payload = 'EVENT/000/' + string.gsub(string[0,16], '')
    puts payload
    return payload
  end
  
  def get_static(string)
    static = "<<<EVENT>>>"
    return static
  end
  
  def get_time(string)
    d = string[0,16].split(' ')
    m = d[2].split(':')
    etime = Time.local(Time.now.year,d[0],d[1],m[0],m[1],m[2]).to_i
    return etime
  end

  def get_loglevel_id(string)
    if string.match(/(fail|error)/i)
      return 2
    else
      return 4
    end
  end
  
end