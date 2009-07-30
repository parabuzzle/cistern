module CollectionServer
   def post_init
    ActiveRecord::Base.logger.info "-- someone connected to the collector"
   end

   def receive_data data
     # Do something with the log data
     ActiveRecord::Base.logger.info "#{data}"
   end

   def unbind
    ActiveRecord::Base.logger.info "-- someone disconnected from the collector"
   end
end

module CommandServer
  def post_init
   
  end

  def receive_data data
    # Do something with the log data
    
  end

  def unbind
   
  end
end
 
