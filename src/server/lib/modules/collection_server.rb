module CollectionServer
  
  #TODO: Checksum check should be wrapped in to an exception and then and handled that way in receive_data
  
  #Set buffer delimiters
  @@break = '__1_BB'
  @@value = '__1_VV'
  @@finish = '__1_EE'
  
  def check_key(agent, key)
    if agent.key != key
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
    static = Logtype.find(map['logtype_id']).staticentries.new
    static.data = map['data']
    static.save
    static = Staticentry.find_by_id(Digest::MD5.hexdigest(map['data']))
    event = static.events.new
    event.time = map['time']
    event.loglevel = map['loglevel']
    event.payload = map['payload']
    event.logtype_id = map['logtype_id']
    event.agent_id = map['agent_id']
    if check_key(Agent.find(map['agent_id']), map['key'])
      event.save
    else
      ActiveRecord::Base.logger.debug "Event dropped -- invalid agent key sent"
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
         if line.valid?
           log_entry(line)
         else
           port, ip = Socket.unpack_sockaddr_in(get_peername)
           host = Socket.getaddrinfo(ip, 0, Socket::AF_UNSPEC, Socket::SOCK_STREAM, nil, Socket::AI_CANONNAME)[0][2]
           ActiveRecord::Base.logger.error "Dropped log entry from #{host} - checksum invalid"
         end
       end
     end
  
  #Do this when a connection is closed by a peer
  def unbind
    ActiveRecord::Base.logger.info "-- Collector connection closed by a peer"
  end

end
 
 