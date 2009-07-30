require 'digest/md5'
module CollectionServer
  
   def post_init
    ActiveRecord::Base.logger.info "-- someone connected to the collector"
   end

   def receive_data(data)
        (@buffer ||= BufferedTokenizer.new(delimiter = "__1_EE")).extract(data).each do |line|
          #receive_line(line)
          puts line
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
 
 