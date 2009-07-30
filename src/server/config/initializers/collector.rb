require 'digest/md5'
module CollectionServer

   def post_init
    port, ip = Socket.unpack_sockaddr_in(get_peername)
    ActiveRecord::Base.logger.info "-- Collector connection established from #{ip}"
   end

   def receive_data(data)
        (@buffer ||= BufferedTokenizer.new(delimiter = "__1_EE")).extract(data).each do |line|
          start = Time.now.to_f
          raw = line.split('__1_B')
          map = Hash.new
          raw.each do |keys|
            parts = keys.split('=')
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
          
        end
      end
   

   def unbind
     ActiveRecord::Base.logger.info "-- Collector connection closed by a peer"
   end
end

module CommandServer
  def post_init
    port, ip = Socket.unpack_sockaddr_in(get_peername)
    ActiveRecord::Base.logger.info "-- Command connection established from #{ip}"
  end

  def receive_data data
    # Do something with the log data
    ActiveRecord::Base.logger.info "#{data}"
  end

  def unbind
   ActiveRecord::Base.logger.info "-- Command connection closed by a peer"
  end
end
 
 