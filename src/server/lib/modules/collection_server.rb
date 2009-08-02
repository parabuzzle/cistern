
module CollectionServer
  
  #TODO: Checksum check should be wrapped in to an exception and then and handled that way

   def post_init
    port, ip = Socket.unpack_sockaddr_in(get_peername)
    ActiveRecord::Base.logger.info "-- Collector connection established from #{ip}"
   end

   def receive_data(data)
        (@buffer ||= BufferedTokenizer.new(delimiter = "__1_EE")).extract(data).each do |line|
          checkintegrity = line.split('__1_CC')
          if checkintegrity[1] == Digest::MD5.hexdigest(checkintegrity[0])
            raw = line.split('__1_BB')
            map = Hash.new
            raw.each do |keys|
              parts = keys.split('__1_VV')
              map.store(parts[0],parts[1])
            end
            static = Logtype.find_by_name(map['logtype']).staticentries.new
            static.data = map['data']
            static.save
            static = Staticentry.find_by_id(Digest::MD5.hexdigest(map['data']))
            event = static.events.new
            event.time = map['time']
            event.loglevel = map['level']
            event.payload = map['payload']
            event.save
            puts "done #{Time.now.to_f - start}"
            port, ip = Socket.unpack_sockaddr_in(get_peername)
            puts "from host #{ip}"
          else
            port, ip = Socket.unpack_sockaddr_in(get_peername)
            ActiveRecord::Base.logger.error "Dropped log entry from #{ip} - checksum invalid"
          end
        end
      end
   

   def unbind
     ActiveRecord::Base.logger.info "-- Collector connection closed by a peer"
   end

end
 
 