module CollectionServer
  
  #TODO: Checksum check should be wrapped in to an exception and then and handled that way in receive_data
  
  #Set buffer delimiters
  @@break = '__1_BB'
  @@value = '__1_VV'
  @@finish = '__1_EE'
  
  def check_key(agent, key)
    if agent.authkey != key
      return false
    else
      return true
    end
  end
  
  #Write a log entry
  def log_entry(line)
    raw = line.split(@@break)
    map = Hash.new
    raw.each do |keys|
      parts = keys.split(@@value)
      map.store(parts[0],parts[1])
    end
    #unless USEMEMCACHE != true
    #  if Staticentry.get_cache(Digest::MD5.hexdigest(map['data'] + map['logtype_id'].to_s)).nil?
    #    static = Logtype.find(map['logtype_id']).staticentries.new
    #    static.data = map['data']
    #    static.save
    #  end
    #else
      static = Logtype.find(map['logtype_id']).staticentries.new
      static.data = map['data']
      static.save
    #end
    unless USEMEMCACHE != true
      static = Staticentry.get_cache(Digest::MD5.hexdigest(map['data'] + map['logtype_id'].to_s))
    else
      static = Staticentry.find(Digest::MD5.hexdigest(map['data'] + map['logtype_id'].to_s))
    end
    event = static.events.new
    event.etime = map['etime'].to_i
    event.loglevel_id = map['loglevel_id'].to_i
    event.payload = map['payload']
    event.logtype_id = map['logtype_id'].to_i
    event.agent_id = map['agent_id'].to_i
    begin
      a = Agent.find(map['agent_id'])
      l = Logtype.find(map['logtype_id'])
      if a.logtypes.member?(l)
        if check_key(a, map['authkey']) 
          event.save
        else
          ActiveRecord::Base.logger.error "Event dropped -- invalid agent authkey sent for #{a.name}"
          send_data "ackerr1"
        end
      else
        ActiveRecord::Base.logger.error "Event dropped -- Agent #{a.name} is not a member of logtype #{l.name}"
        send_data "ackerr2"
      end
    rescue ActiveRecord::RecordNotFound
      ActiveRecord::Base.logger.error "Event dropped -- invalid agent_id or logtype_id specified"
      send_data "ackerr3"
    end
    port, ip = Socket.unpack_sockaddr_in(get_peername)
    host = Socket.getaddrinfo(ip, 0, Socket::AF_UNSPEC, Socket::SOCK_STREAM, nil, Socket::AI_CANONNAME)[0][2]
    ActiveRecord::Base.logger.debug "New event logged from #{host} \n -- Log data: #{line}"
  end
  
  #Do this when a connection is initialized
  def post_init
   port, ip = Socket.unpack_sockaddr_in(get_peername)
   host = Socket.getaddrinfo(ip, 0, Socket::AF_UNSPEC, Socket::SOCK_STREAM, nil, Socket::AI_CANONNAME)[0][2]
   ActiveRecord::Base.logger.info "-- Collector connection established from #{host}"
  end
  
  #Do this when data is received
  def receive_data(data)
       (@buffer ||= BufferedTokenizer.new(delimiter = "__1_EE")).extract(data).each do |line|
         #strip newline at beginning of line
         if line.match(/^\W{1}./)
           line = line[1..line.length-1]
         end
         if line.valid?
           log_entry(line)
           send_data "ackok"
         else
           port, ip = Socket.unpack_sockaddr_in(get_peername)
           host = Socket.getaddrinfo(ip, 0, Socket::AF_UNSPEC, Socket::SOCK_STREAM, nil, Socket::AI_CANONNAME)[0][2]
           ActiveRecord::Base.logger.error "Dropped log entry from #{host} - checksum invalid"
           send_data "ackerr0"
         end
       end
     end
  
  #Do this when a connection is closed by a peer
  def unbind
    ActiveRecord::Base.logger.info "-- Collector connection closed by a peer"
  end

end
 
 