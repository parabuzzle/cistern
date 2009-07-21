module CollectionServer
   def post_init
    ActiveRecord::Base.logger.info "-- someone connected to the collector"
   end

   def receive_data data
     # Do something with the log data
     ActiveRecord::Base.logger.info "New Event - #{data}"
   end

   def unbind
    ActiveRecord::Base.logger.info "-- someone disconnected to the collector"
   end
 end