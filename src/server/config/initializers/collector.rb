require 'digest/md5'
module CollectionServer

   def post_init
    ActiveRecord::Base.logger.info "-- someone connected to the collector"
   end

   def receive_data(data)
     n = 1
        (@buffer ||= BufferedTokenizer.new(delimiter = "__1_EE")).extract(data).each do |line|
          start = Time.now.to_i
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
          puts "done #{Time.now.to_i - start} #{n + 1}"
        end
      end
   

   def unbind
    ActiveRecord::Base.logger.info "-- someone disconnected from the collector"
   end
end

module CommandServer
  def post_init
   ActiveRecord::Base.logger.info "-- someone connected to the command server"
  end

  def receive_data data
    # Do something with the log data
    ActiveRecord::Base.logger.info "#{data}"
  end

  def unbind
   ActiveRecord::Base.logger.info "-- someone disconnected from the command server"
  end
end
 
 